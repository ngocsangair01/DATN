package com.ms.tourist_app.config.exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
public class ResponseException extends RuntimeException{
    private HttpStatus status;
    private String message;

    public ResponseException(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }
}
