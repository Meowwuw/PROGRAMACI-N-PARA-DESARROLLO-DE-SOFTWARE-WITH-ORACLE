package com.vet.backend.dto;

import com.vet.backend.model.Registro_Login;
import java.time.LocalDateTime;

public record Registro_LoginResponse(
        Integer idRegistro,
        Integer idUsuario,
        String usernameIntentado,
        LocalDateTime fechaHora,
        Boolean exito,
        String ipOrigen,
        String dispositivo
) {
    public static Registro_LoginResponse from(Registro_Login r) {
        return new Registro_LoginResponse(
                r.getIdRegistro(), r.getIdUsuario(), r.getUsernameIntentado(),
                r.getFechaHora(), r.getExito(), r.getIpOrigen(), r.getDispositivo());
    }
}