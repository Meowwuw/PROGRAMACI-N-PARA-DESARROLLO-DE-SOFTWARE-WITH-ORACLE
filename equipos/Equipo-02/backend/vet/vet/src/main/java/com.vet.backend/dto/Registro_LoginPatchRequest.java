package com.vet.backend.dto;

import jakarta.validation.constraints.Size;

/** Cuerpo para PATCH: solo se actualizan los campos que vengan no nulos. */
public record Registro_LoginPatchRequest(
        Integer idUsuario,
        @Size(max = 50) String usernameIntentado,
        Boolean exito,
        @Size(max = 45) String ipOrigen,
        @Size(max = 255) String dispositivo
) {}