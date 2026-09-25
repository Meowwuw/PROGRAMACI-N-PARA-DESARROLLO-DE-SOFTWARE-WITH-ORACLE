package com.canchavoley.backend.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "pago", schema = "renta_cancha")
public class Pago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pago")
    private Long idPago;

    @OneToOne
    @JoinColumn(name = "id_reserva", nullable = false, unique = true)
    private Reserva reserva;

    @Column(name = "total", nullable = false, precision = 10, scale = 2)
    private BigDecimal total;

    public Pago() {
    }

    public Pago(Long idPago, Reserva reserva, BigDecimal total) {
        this.idPago = idPago;
        this.reserva = reserva;
        this.total = total;
    }

    public Long getIdPago() {
        return idPago;
    }

    public void setIdPago(Long idPago) {
        this.idPago = idPago;
    }

    public Reserva getReserva() {
        return reserva;
    }

    public void setReserva(Reserva reserva) {
        this.reserva = reserva;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }
}