package com.vet.backend.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "registro_login", schema = "a_veterinaria")
public class Registro_Login {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // SERIAL en PostgreSQL
    @Column(name = "id_registro")
    private Integer idRegistro;

    // Nullable: la BD usa ON DELETE SET NULL y tambien se registran
    // intentos con usernames que no existen.
    @Column(name = "id_usuario")
    private Integer idUsuario;

    @Column(name = "username_intentado", nullable = false, length = 50)
    private String usernameIntentado;

    @Column(name = "fecha_hora", nullable = false)
    private LocalDateTime fechaHora;

    @Column(name = "exito", nullable = false)
    private Boolean exito;

    @Column(name = "ip_origen", length = 45)
    private String ipOrigen;

    @Column(name = "dispositivo", length = 255)
    private String dispositivo;

    @PrePersist
    void prePersist() {
        if (fechaHora == null) fechaHora = LocalDateTime.now();
    }

    public Registro_Login() {}

    public Integer getIdRegistro() { return idRegistro; }
    public void setIdRegistro(Integer idRegistro) { this.idRegistro = idRegistro; }
    public Integer getIdUsuario() { return idUsuario; }
    public void setIdUsuario(Integer idUsuario) { this.idUsuario = idUsuario; }
    public String getUsernameIntentado() { return usernameIntentado; }
    public void setUsernameIntentado(String usernameIntentado) { this.usernameIntentado = usernameIntentado; }
    public LocalDateTime getFechaHora() { return fechaHora; }
    public void setFechaHora(LocalDateTime fechaHora) { this.fechaHora = fechaHora; }
    public Boolean getExito() { return exito; }
    public void setExito(Boolean exito) { this.exito = exito; }
    public String getIpOrigen() { return ipOrigen; }
    public void setIpOrigen(String ipOrigen) { this.ipOrigen = ipOrigen; }
    public String getDispositivo() { return dispositivo; }
    public void setDispositivo(String dispositivo) { this.dispositivo = dispositivo; }
}