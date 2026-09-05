package com.vet.backend.model;

public class Consulta {
    private Long id;
    private String motivo;
    private String fecha;
    private String diagnostico;

    public Consulta() {
    }

    public Consulta(Long id, String motivo, String fecha, String diagnostico) {
        this.id = id;
        this.motivo = motivo;
        this.fecha = fecha;
        this.diagnostico = diagnostico;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getDiagnostico() {
        return diagnostico;
    }

    public void setDiagnostico(String diagnostico) {
        this.diagnostico = diagnostico;
    }

    @Override
    public String toString() {
        return "Consulta{" +
                "id=" + id +
                ", motivo='" + motivo + '\'' +
                ", fecha='" + fecha + '\'' +
                ", diagnostico='" + diagnostico + '\'' +
                '}';
    }
}