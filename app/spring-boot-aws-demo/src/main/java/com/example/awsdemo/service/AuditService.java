package com.example.awsdemo.service;

import com.example.awsdemo.domain.AuditEvent;
import com.example.awsdemo.repository.AuditEventRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuditService {

    private final AuditEventRepository repository;

    public AuditService(AuditEventRepository repository) {
        this.repository = repository;
    }

    public AuditEvent create(String action, String actor) {
        return repository.save(new AuditEvent(action, actor));
    }

    public Optional<AuditEvent> getById(Long id) {
        return repository.findById(id);
    }
}
