package com.cat.notification;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    @Autowired
    private NotificationRepository repository;

    @GetMapping("/test")
    public String test() {
        return "Notification Service is UP on port 8124";
    }

    @GetMapping("/all")
    public List<Notification> getAll() {
        return repository.findAll();
    }
}