package com.vet.backend.dto;

public record AuthResponse(
        Long idUsuario,
        String username,
        String email,
        String rol
) {}