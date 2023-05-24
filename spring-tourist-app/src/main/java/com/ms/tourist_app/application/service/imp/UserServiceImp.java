package com.ms.tourist_app.application.service.imp;

import com.ms.tourist_app.application.constants.AppStr;
import com.ms.tourist_app.application.dai.*;
import com.ms.tourist_app.application.input.users.AddFavoriteDestinationInput;
import com.ms.tourist_app.application.input.users.UserDataInput;
import com.ms.tourist_app.application.input.users.GetListUserInput;
import com.ms.tourist_app.application.mapper.DestinationMapper;
import com.ms.tourist_app.application.mapper.UserMapper;
import com.ms.tourist_app.application.output.destinations.DestinationDataOutput;
import com.ms.tourist_app.application.output.users.UserDataOutput;
import com.ms.tourist_app.application.service.UserService;
import com.ms.tourist_app.application.utils.JwtUtil;
import com.ms.tourist_app.config.exception.BadRequestException;
import com.ms.tourist_app.config.exception.ForbiddenException;
import com.ms.tourist_app.config.exception.NotFoundException;
import com.ms.tourist_app.domain.entity.*;
import org.mapstruct.factory.Mappers;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;


@Service
public class UserServiceImp implements UserService {
    private final UserMapper userMapper = Mappers.getMapper(UserMapper.class);
    private final UserRepository userRepository;
    private final AddressRepository addressRepository;
    private final DestinationRepository destinationRepository;

    private final RoleRepository roleRepository;
    private final ImageDestinationRepository imageDestinationRepository;
    private final JwtUtil jwtUtil;
    private final DestinationMapper destinationMapper = Mappers.getMapper(DestinationMapper.class);

    public UserServiceImp(UserRepository userRepository, AddressRepository addressRepository,
                          DestinationRepository destinationRepository, RoleRepository roleRepository, ImageDestinationRepository imageDestinationRepository, JwtUtil jwtUtil) {
        this.userRepository = userRepository;
        this.addressRepository = addressRepository;
        this.destinationRepository = destinationRepository;
        this.roleRepository = roleRepository;
        this.imageDestinationRepository = imageDestinationRepository;
        this.jwtUtil = jwtUtil;
    }


    private boolean checkUserEmailExists(String email) {
        User user = userRepository.findByEmail(email);
        return user != null;

    }

    private boolean checkUserTelephoneExists(String telephone) {
        User user = userRepository.findByTelephone(telephone);
        return user != null;
    }

    private boolean checkUserExists(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.isPresent();
    }

    @Override
    @Transactional
    public UserDataOutput createUser(UserDataInput input) {
        if (checkUserTelephoneExists(input.getTelephone())) {
            throw new BadRequestException(AppStr.User.telephone + AppStr.Base.whiteSpace + AppStr.Exception.duplicate);
        }
        if (checkUserEmailExists(input.getEmail())) {
            throw new BadRequestException(AppStr.User.email + AppStr.Base.whiteSpace + AppStr.Exception.duplicate);
        }
        User user = userMapper.toUser(input,null);
        Optional<Address> address = addressRepository.findById(input.getIdAddress());
        user.setAddress(address.get());
        userRepository.save(user);
        return new UserDataOutput(user.getId(), user.getFirstName(), user.getLastName(), user.getDateOfBirth(),address.get(), user.getTelephone(), user.getEmail(), user.getPassword());
    }
    @Override
    @Transactional
    public List<UserDataOutput> getListUserOutPut(GetListUserInput input) {

        List<User> users = new ArrayList<>();
        if(input.getKeyword().trim().isBlank()){
            users = userRepository.findAll(PageRequest.of(input.getPage(), input.getSize())).getContent();
        }
        if(!input.getKeyword().trim().isBlank()){
            users = userRepository.search(input.getKeyword().trim(),PageRequest.of(input.getPage(), input.getSize()));
        }
        List<UserDataOutput> userDataOutputs = new ArrayList<>();
        for (User u : users) {
            UserDataOutput userDataOutput = userMapper.toUserDataOutput(u);
            userDataOutput.setAddress(u.getAddress());
            userDataOutputs.add(userDataOutput);
        }
        return userDataOutputs;
    }

    @Override
    @Transactional
    public UserDataOutput getUserDataOutput(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (!checkUserExists(id)) {
            throw new NotFoundException(AppStr.User.user + AppStr.Base.whiteSpace + AppStr.Exception.notFound);
        }
        UserDataOutput userDataOutput = userMapper.toUserDataOutput(user.get());
        userDataOutput.setAddress(user.get().getAddress());
        return userDataOutput;
    }

    @Override
    @Transactional
    public UserDataOutput editUser(Long id, UserDataInput input) {
        if (!checkUserExists(id)) {
            throw new NotFoundException(AppStr.User.user + AppStr.Base.whiteSpace + AppStr.Exception.notFound);
        }
        User user = userMapper.toUser(input,id);
        if (input.getIdAddress() != null) {
            Optional<Address> address = addressRepository.findById(input.getIdAddress());
            if (address.isEmpty()){
                throw new NotFoundException(AppStr.Address.address+AppStr.Base.whiteSpace+AppStr.Exception.notFound);
            }
            address.ifPresent(user::setAddress);
        }
        user.setId(id);

        userRepository.save(user);
        UserDataOutput userDataOutput = userMapper.toUserDataOutput(user);
        userDataOutput.setAddress(user.getAddress());
        return userDataOutput;
    }

    @Override
    @Transactional
    public UserDataOutput deleteUser(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (!checkUserExists(id)) {
            throw new NotFoundException(AppStr.User.user + AppStr.Base.whiteSpace + AppStr.Exception.notFound);
        }
        for (Role role : user.get().getRoles()) {
            role.getUsers().remove(user.get());
        }
        user.get().getRoles().clear();
        userRepository.delete(user.get());
        UserDataOutput userDataOutput = userMapper.toUserDataOutput(user.get());
        Address address = user.get().getAddress();
        userDataOutput.setAddress(address);
        return userDataOutput;
    }

    @Override
    @Transactional
    public DestinationDataOutput addFavoriteDestination(AddFavoriteDestinationInput input) {
        if (jwtUtil.getUserIdFromToken() == null){
            throw new ForbiddenException(AppStr.Exception.forbidden);
        }
        Long userId = jwtUtil.getUserIdFromToken();
        Optional<User> optionalUser = userRepository.findById(userId);
        if (optionalUser.isEmpty()){
            throw new NotFoundException("User not exists");
        }
        User user = optionalUser.get();
        List<Destination> favoriteDest = optionalUser.get().getFavoriteDestination();
        Optional<Destination> destination = destinationRepository.findById(input.getDestinationId());
        if (destination.isEmpty()){
            throw new NotFoundException(AppStr.Exception.notFound+AppStr.Base.whiteSpace+AppStr.Destination.tableDestination);
        }
        if (favoriteDest.contains(destination.get())) {
            DestinationDataOutput output = destinationMapper.toDestinationDataOutput(destination.get());
            return output;
        }
        List<User> listFavUsers = destination.get().getFavoriteUsers();
        List<User> newFavUsers = new ArrayList<>(listFavUsers);
        newFavUsers.add(user);
        destination.get().setFavoriteUsers(newFavUsers);
        destinationRepository.save(destination.get());

        List<Destination> newFavDestination = new ArrayList<>(favoriteDest);
        newFavDestination.add(destination.get());
        user.setFavoriteDestination(newFavDestination);
        userRepository.save(user);
        System.out.println(1);
        DestinationDataOutput output = destinationMapper.toDestinationDataOutput(destination.get());
        System.out.println(2);
        return output;
    }

    @Override
    @Transactional
    public List<DestinationDataOutput> viewFavoriteDestinations() {
        if (jwtUtil.getUserIdFromToken() == null){
            throw new ForbiddenException(AppStr.Exception.forbidden);
        }
        Long userId = jwtUtil.getUserIdFromToken();
        User user = userRepository.findById(userId).get();
        List<Destination> listFavDests = user.getFavoriteDestination();
        List<DestinationDataOutput> outputs = new ArrayList<>();
        for (Destination dest : listFavDests) {
            DestinationDataOutput output = destinationMapper.toDestinationDataOutput(dest);
            List<ImageDestination> imageDestinations = imageDestinationRepository.findAllByDestination(dest);
            List<String> imageDestinationOutputs = new ArrayList<>();
            for (ImageDestination imageDestination : imageDestinations) {
                String imageDestinationOutput = imageDestination.getLink();
                imageDestinationOutputs.add(imageDestinationOutput);
            }
            output.setImages(imageDestinationOutputs);
            outputs.add(output);
        }
        return outputs;
    }

    @Override
    @Transactional
    public DestinationDataOutput deleteFavoriteDestination(Long id) {
        if (jwtUtil.getUserIdFromToken() == null){
            throw new ForbiddenException(AppStr.Exception.forbidden);
        }
        Long userId = jwtUtil.getUserIdFromToken();
        Optional<User> user = userRepository.findById(userId);
        if(user.isEmpty()){
            throw new NotFoundException(AppStr.Exception.notFound+AppStr.Base.whiteSpace+AppStr.User.user);
        }
        List<Destination> listFavDests = user.get().getFavoriteDestination();

        Optional<Destination> destinationToDelete = destinationRepository.findById(id);

        if(destinationToDelete.isEmpty()){
            throw new NotFoundException(AppStr.Exception.notFound+AppStr.Base.whiteSpace+AppStr.User.user);
        }
        if (!listFavDests.contains(destinationToDelete.get())) {
            throw new BadRequestException(AppStr.User.notFoundFavoriteDestination);
        }
        List<User> listFavUsers = destinationToDelete.get().getFavoriteUsers();
        for (User user1 :
                listFavUsers) {
            user1.getFavoriteDestination().remove(destinationToDelete.get());
            userRepository.save(user1);
        }
        destinationToDelete.get().setFavoriteUsers(null);
        DestinationDataOutput output = destinationMapper.toDestinationDataOutput(destinationToDelete.get());
        return output;
    }
}
