package com.example.awsdemo.dto;

public class CreateAuditRequest {

    private String action;
    private String actor;

    public String getAction() {
        return action;
    }

    public String getActor() {
        return actor;
    }
}
