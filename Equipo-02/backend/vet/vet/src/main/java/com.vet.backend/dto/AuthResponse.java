package com.vet.backend.dto;

public record AuthResponse(
        Long idUsuario,
        String username,
        String email,
        String rol,
        Long idApoderado,   // no-nulo solo si el usuario es un apoderado
        Long idVeterinario  // no-nulo solo si el usuario es un veterinario
) {}
