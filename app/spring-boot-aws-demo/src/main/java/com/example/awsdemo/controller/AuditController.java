package com.example.awsdemo.controller;

import com.example.awsdemo.domain.AuditEvent;
import com.example.awsdemo.dto.AuditResponse;
import com.example.awsdemo.dto.CreateAuditRequest;
import com.example.awsdemo.service.AuditService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/audit")
public class AuditController {

    private final AuditService service;

    public AuditController(AuditService service) {
        this.service = service;
    }

    @PostMapping
    public ResponseEntity<AuditResponse> create(@RequestBody CreateAuditRequest request) {
        AuditEvent event = service.create(request.getAction(), request.getActor());
        return ResponseEntity.ok(toResponse(event));
    }

    @GetMapping("/{id}")
    public ResponseEntity<AuditResponse> get(@PathVariable Long id) {
        return service.getById(id)
                .map(event -> ResponseEntity.ok(toResponse(event)))
                .orElse(ResponseEntity.notFound().build());
    }

    private AuditResponse toResponse(AuditEvent event) {
        return new AuditResponse(
                event.getId(),
                event.getAction(),
                event.getActor(),
                event.getCreatedAt()
        );
    }
}
