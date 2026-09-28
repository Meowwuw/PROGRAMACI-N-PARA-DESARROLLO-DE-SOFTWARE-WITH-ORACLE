package com.serviciocancha.model;
import jakarta.persistence.*;

@Entity
@Table(name = "cancha")

public class Cancha {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(name = "tipo_deporte", nullable = false, length = 50)
    private String tipoDeporte;

    @Column(name = "precio_por_hora", nullable = false)
    private Double precioPorHora;

    @Column(length = 20)
    private String estado = "disponible";

    public Cancha() {}

    public Cancha(Integer id, String nombre, String tipoDeporte, Double precioPorHora, String estado) {
        this.id = id;
        this.nombre = nombre;
        this.tipoDeporte = tipoDeporte;
        this.precioPorHora = precioPorHora;
        this.estado = estado;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getTipoDeporte() { return tipoDeporte; }
    public void setTipoDeporte(String tipoDeporte) { this.tipoDeporte = tipoDeporte; }
    public Double getPrecioPorHora() { return precioPorHora; }
    public void setPrecioPorHora(Double precioPorHora) { this.precioPorHora = precioPorHora; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
