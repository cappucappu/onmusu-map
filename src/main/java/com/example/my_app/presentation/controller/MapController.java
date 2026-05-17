package com.example.my_app.presentation.controller;

import com.example.my_app.application.Scenario.OnmusuScenario;
import com.example.my_app.application.dto.OnmusuResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


@Controller
@RequiredArgsConstructor
public class MapController {

    private final OnmusuScenario onmusuScenario;

    @GetMapping("/map")
    public String getMethodName(Model model) {

        List<OnmusuResponse> onmusuList = onmusuScenario.getAll();

        model.addAttribute("onmusuList", onmusuList);
        return "map";
    }

}
