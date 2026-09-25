package com.vet.backend.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

/** Cuerpo para POST y PUT. */
public record RolRequest(
        @NotBlank @Size(max = 30) String nombreRol
) {}