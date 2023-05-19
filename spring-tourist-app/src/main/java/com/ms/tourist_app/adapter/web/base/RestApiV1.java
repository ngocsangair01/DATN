package com.ms.tourist_app.adapter.web.base;

import com.ms.tourist_app.application.constants.UrlConst;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.lang.annotation.*;

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@RestController
@RequestMapping(UrlConst.apiV1)
public @interface RestApiV1 {
}
