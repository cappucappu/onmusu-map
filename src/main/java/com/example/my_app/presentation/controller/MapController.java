package com.example.my_app.presentation.controller;

import com.example.my_app.application.OnmusuService;
import com.example.my_app.presentation.dto.OnmusuResponse;
import com.example.my_app.presentation.converter.OnmusuConverter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


@Controller
@RequiredArgsConstructor
public class MapController {

    private final OnmusuService onmusuService;
    private final OnmusuConverter onmusuConverter;

    @GetMapping("/map")
    public String getMethodName(Model model) {

        List<OnmusuResponse> onmusuList = onmusuConverter.toResponseList(onmusuService.getAllMarker());

        model.addAttribute("onmusuList", onmusuList);
        return "map";
    }

}
