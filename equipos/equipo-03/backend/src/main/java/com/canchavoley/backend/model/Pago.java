package com.canchavoley.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "pago", schema = "renta_cancha")
public class Pago {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "id_reserva")
    private Long idReserva;

    @Column(name = "total")
    private Double total;

    public Pago() {
    }

    public Pago(Long id, Long idReserva, Double total) {
        this.id = id;
        this.idReserva = idReserva;
        this.total = total;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getIdReserva() { return idReserva; }
    public void setIdReserva(Long idReserva) { this.idReserva = idReserva; }

    public Double getTotal() { return total; }
    public void setTotal(Double total) { this.total = total; }
}
