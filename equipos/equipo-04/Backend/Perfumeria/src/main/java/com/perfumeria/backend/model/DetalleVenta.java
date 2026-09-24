package com.perfumeria.backend.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "detalle_venta", schema = "a_perfumeria")
public class DetalleVenta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_detalle")
    private Long id;

    @Column(name = "id_venta")
    private Long idVenta;

    @Column(name = "id_perfume")
    private Long idPerfume;

    private Integer cantidad;

    @Column(name = "precio_unitario")
    private BigDecimal precioUnitario;

    private BigDecimal descuento;

    // Columna GENERATED ALWAYS en la BD: solo lectura, no se envía en INSERT/UPDATE
    @Column(name = "subtotal", insertable = false, updatable = false)
    private BigDecimal subtotal;

    public DetalleVenta() {
    }

    public DetalleVenta(Long id, Long idVenta, Long idPerfume, Integer cantidad,
                        BigDecimal precioUnitario, BigDecimal descuento) {
        this.id = id;
        this.idVenta = idVenta;
        this.idPerfume = idPerfume;
        this.cantidad = cantidad;
        this.precioUnitario = precioUnitario;
        this.descuento = descuento;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(Long idVenta) {
        this.idVenta = idVenta;
    }

    public Long getIdPerfume() {
        return idPerfume;
    }

    public void setIdPerfume(Long idPerfume) {
        this.idPerfume = idPerfume;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public BigDecimal getPrecioUnitario() {
        return precioUnitario;
    }

    public void setPrecioUnitario(BigDecimal precioUnitario) {
        this.precioUnitario = precioUnitario;
    }

    public BigDecimal getDescuento() {
        return descuento;
    }

    public void setDescuento(BigDecimal descuento) {
        this.descuento = descuento;
    }

    public BigDecimal getSubtotal() {
        return subtotal;
    }
}
