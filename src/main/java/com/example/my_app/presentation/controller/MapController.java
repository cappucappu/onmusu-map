package com.example.my_app.presentation.controller;

import com.example.my_app.application.OnmusuMarker;
import com.example.my_app.infrastructure.entity.Onmusu;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


@Controller
@RequiredArgsConstructor
public class MapController {

    private final OnmusuMarker onmusuMarker;

    @GetMapping("/map")
    public String getMethodName(Model model) {

        List<Onmusu> onmusuList = onmusuMarker.getAllMarker();

        model.addAttribute("onmusuMarkers", onmusuList);
        return "map";
    }

}
