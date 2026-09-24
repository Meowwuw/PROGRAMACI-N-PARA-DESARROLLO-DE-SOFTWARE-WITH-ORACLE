package com.vet.backend.service;

import com.vet.backend.dto.Registro_LoginPatchRequest;
import com.vet.backend.dto.Registro_LoginRequest;
import com.vet.backend.dto.Registro_LoginResponse;
import com.vet.backend.model.Registro_Login;
import com.vet.backend.repository.Registro_LoginRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;

@Service
public class Registro_LoginService {

    private final Registro_LoginRepository repository;

    public Registro_LoginService(Registro_LoginRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public Page<Registro_LoginResponse> listar(Integer idUsuario, String username,
                                               Boolean exito, Pageable pageable) {
        String user = (username == null || username.isBlank()) ? null : username.trim().toLowerCase();
        return repository.buscar(idUsuario, user, exito, pageable)
                .map(Registro_LoginResponse::from);
    }

    @Transactional(readOnly = true)
    public Registro_LoginResponse obtenerPorId(Integer id) {
        return Registro_LoginResponse.from(buscarOFallar(id));
    }

    @Transactional(readOnly = true)
    public boolean existe(Integer id) {
        return repository.existsById(id);
    }

    @Transactional(readOnly = true)
    public long contarFallidosRecientes(String username, int minutos) {
        return repository.countByUsernameIntentadoIgnoreCaseAndExitoFalseAndFechaHoraAfter(
                username, LocalDateTime.now().minusMinutes(minutos));
    }

    @Transactional
    public Registro_LoginResponse crear(Registro_LoginRequest req) {
        Registro_Login r = new Registro_Login();
        aplicarCompleto(r, req);
        return Registro_LoginResponse.from(repository.save(r));
    }

    /** PUT: reemplaza todos los campos editables (fecha_hora no se toca). */
    @Transactional
    public Registro_LoginResponse actualizar(Integer id, Registro_LoginRequest req) {
        Registro_Login r = buscarOFallar(id);
        aplicarCompleto(r, req);
        return Registro_LoginResponse.from(repository.save(r));
    }

    /** PATCH: solo cambia lo que venga no nulo. */
    @Transactional
    public Registro_LoginResponse actualizarParcial(Integer id, Registro_LoginPatchRequest req) {
        Registro_Login r = buscarOFallar(id);
        if (req.idUsuario() != null)         r.setIdUsuario(req.idUsuario());
        if (req.usernameIntentado() != null) r.setUsernameIntentado(req.usernameIntentado());
        if (req.exito() != null)             r.setExito(req.exito());
        if (req.ipOrigen() != null)          r.setIpOrigen(req.ipOrigen());
        if (req.dispositivo() != null)       r.setDispositivo(req.dispositivo());
        return Registro_LoginResponse.from(repository.save(r));
    }

    @Transactional
    public void eliminar(Integer id) {
        if (!repository.existsById(id)) throw noEncontrado(id);
        repository.deleteById(id);
    }

    // ---------- helpers ----------

    private void aplicarCompleto(Registro_Login r, Registro_LoginRequest req) {
        r.setIdUsuario(req.idUsuario());
        r.setUsernameIntentado(req.usernameIntentado());
        r.setExito(req.exito());
        r.setIpOrigen(req.ipOrigen());
        r.setDispositivo(req.dispositivo());
    }

    private Registro_Login buscarOFallar(Integer id) {
        return repository.findById(id).orElseThrow(() -> noEncontrado(id));
    }

    private ResponseStatusException noEncontrado(Integer id) {
        return new ResponseStatusException(HttpStatus.NOT_FOUND,
                "Registro de login no encontrado: " + id);
    }
}