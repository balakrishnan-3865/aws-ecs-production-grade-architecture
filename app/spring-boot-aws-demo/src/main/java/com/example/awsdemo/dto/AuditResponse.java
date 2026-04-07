package com.example.awsdemo.dto;

import java.time.Instant;

public class AuditResponse {

    private Long id;
    private String action;
    private String actor;
    private Instant createdAt;

    public AuditResponse(Long id, String action, String actor, Instant createdAt) {
        this.id = id;
        this.action = action;
        this.actor = actor;
        this.createdAt = createdAt;
    }

    public Long getId() {
        return id;
    }

    public String getAction() {
        return action;
    }

    public String getActor() {
        return actor;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }
}
