package com.vet.backend.dto;

import com.vet.backend.model.Rol;

public record RolResponse(
        Integer idRol,
        String nombreRol
) {
    public static RolResponse from(Rol r) {
        return new RolResponse(r.getIdRol(), r.getNombreRol());
    }
}