package com.perfumeria.backend.model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "venta", schema = "public")
public class Venta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_venta")
    private Long id;

    @Column(name = "id_cliente")
    private Long idCliente;

    @Column(name = "fecha_hora")
    private LocalDateTime fechaHora;

    @Column(name = "metodo_pago")
    private String metodoPago;

    @Column(name = "tipo_comprobante")
    private String tipoComprobante;

    @Column(name = "monto_total")
    private Double montoTotal;

    @Column(name = "estado_venta")
    private String estadoVenta;

    public Venta() {
    }

    public Venta(Long id, Long idCliente, LocalDateTime fechaHora, String metodoPago, String tipoComprobante, Double montoTotal, String estadoVenta) {
        this.id = id;
        this.idCliente = idCliente;
        this.fechaHora = fechaHora;
        this.metodoPago = metodoPago;
        this.tipoComprobante = tipoComprobante;
        this.montoTotal = montoTotal;
        this.estadoVenta = estadoVenta;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Long idCliente) {
        this.idCliente = idCliente;
    }

    public LocalDateTime getFechaHora() {
        return fechaHora;
    }

    public void setFechaHora(LocalDateTime fechaHora) {
        this.fechaHora = fechaHora;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getTipoComprobante() {
        return tipoComprobante;
    }

    public void setTipoComprobante(String tipoComprobante) {
        this.tipoComprobante = tipoComprobante;
    }

    public Double getMontoTotal() {
        return montoTotal;
    }

    public void setMontoTotal(Double montoTotal) {
        this.montoTotal = montoTotal;
    }

    public String getEstadoVenta() {
        return estadoVenta;
    }

    public void setEstadoVenta(String estadoVenta) {
        this.estadoVenta = estadoVenta;
    }
}
