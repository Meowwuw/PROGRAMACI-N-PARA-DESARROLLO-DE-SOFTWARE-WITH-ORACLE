package com.vet.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

/** Cuerpo para POST y PUT (todos los campos obligatorios salvo los opcionales). */
public record Registro_LoginRequest(
        Integer idUsuario,                                   // opcional
        @NotBlank @Size(max = 50) String usernameIntentado,
        @NotNull Boolean exito,
        @Size(max = 45) String ipOrigen,                     // opcional
        @Size(max = 255) String dispositivo                  // opcional
) {}