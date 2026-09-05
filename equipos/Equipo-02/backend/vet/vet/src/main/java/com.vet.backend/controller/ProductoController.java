package controller;

import com.vet.backend.service.ProductoServices;
import com.vet.backend.model.Producto;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import java.util.List;

public class ProductoController {
    private final ProductoServices productoServices;

    public ProductoController(ProductoServices productoServices){
        this.productoServices = productoServices;
    }

    @GetMapping
    public List<Producto> listar(){
        return productoServices.listar();
    }

    @GetMapping("/destacado")
    public Producto destacado(){
        return new Producto(
                2L,
                "monitorBig",
                750.00, "periferico");
    }

    @GetMapping("{id}")
    public Producto buscarPorId(@PathVariable Long id){
        return new Producto(
                id,
                "Producto Prueba",
                99.9,
                "Prueba"
        );
    }
}