package com.vet.backend.dto;

import jakarta.validation.constraints.Size;

/** Cuerpo para PATCH: solo se actualiza lo que venga no nulo. */
public record RolPatchRequest(
        @Size(max = 30) String nombreRol
) {}