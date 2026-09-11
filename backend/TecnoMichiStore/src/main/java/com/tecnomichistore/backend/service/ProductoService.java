package com.tecnomichistore.backend.service;

import com.tecnomichistore.backend.model.Producto;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoService {

    public List<Producto> listar(){
        return List.of(
                new Producto(1L,"Laptop Michina",2500.00,"Laptops"),
                new Producto(2L,"Mouse Michi Gamer",75.50,"Perifericos"),
                new Producto(3L,"Teclado Cat",120.00,"Perifericos")
        );
    }

}
