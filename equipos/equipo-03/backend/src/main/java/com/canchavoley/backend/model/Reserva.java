package com.canchavoley.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "reserva")
public class Reserva {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_cliente")
    private Integer idCliente;

    @Column(name = "id_cancha")
    private Integer idCancha;

    @Column(name = "id_horario")
    private Integer idHorario;

    @Column(name = "horas_alquilado")
    private Integer horasAlquilado;

    private String fecha;

    public Reserva() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdCliente() { return idCliente; }
    public void setIdCliente(Integer idCliente) { this.idCliente = idCliente; }

    public Integer getIdCancha() { return idCancha; }
    public void setIdCancha(Integer idCancha) { this.idCancha = idCancha; }

    public Integer getIdHorario() { return idHorario; }
    public void setIdHorario(Integer idHorario) { this.idHorario = idHorario; }

    public Integer getHorasAlquilado() { return horasAlquilado; }
    public void setHorasAlquilado(Integer horasAlquilado) { this.horasAlquilado = horasAlquilado; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }
}