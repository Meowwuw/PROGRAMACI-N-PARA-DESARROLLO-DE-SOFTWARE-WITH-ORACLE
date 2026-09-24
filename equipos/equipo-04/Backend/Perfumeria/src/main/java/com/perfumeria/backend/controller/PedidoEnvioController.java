package com.perfumeria.backend.controller;

import com.perfumeria.backend.model.PedidoEnvio;
import com.perfumeria.backend.service.PedidoEnvioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pedidos")
public class PedidoEnvioController {

    @Autowired
    private PedidoEnvioService pedidoEnvioService;

    @GetMapping
    public List<PedidoEnvio> listarTodos() {
        return pedidoEnvioService.listarTodos();
    }

    @GetMapping("/{id}")
    public ResponseEntity<PedidoEnvio> buscarPorId(@PathVariable Long id) {
        return pedidoEnvioService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<PedidoEnvio> crear(@RequestBody PedidoEnvio pedido) {
        PedidoEnvio nuevoPedido = pedidoEnvioService.guardar(pedido);
        return ResponseEntity.status(HttpStatus.CREATED).body(nuevoPedido);
    }

    @PutMapping("/{id}")
    public ResponseEntity<PedidoEnvio> actualizar(@PathVariable Long id, @RequestBody PedidoEnvio pedido) {
        PedidoEnvio pedidoActualizado = pedidoEnvioService.actualizar(id, pedido);
        if (pedidoActualizado != null) {
            return ResponseEntity.ok(pedidoActualizado);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        boolean eliminado = pedidoEnvioService.eliminar(id);
        if (eliminado) {
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}
