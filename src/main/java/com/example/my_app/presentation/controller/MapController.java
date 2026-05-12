package com.example.my_app.presentation.controller;

import com.example.my_app.application.OnmusuMarker;
import com.example.my_app.infrastructure.entity.Onmusu;
import com.example.my_app.presentation.dto.OnmusuResponse;
import com.example.my_app.presentation.mapper.OnmusuMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;


@Controller
@RequiredArgsConstructor
public class MapController {

    private final OnmusuMarker onmusuMarker;
    private final OnmusuMapper onmusuMapper;

    @GetMapping("/map")
    public String getMethodName(Model model) {

        List<OnmusuResponse> onmusuList = onmusuMapper.toResponseList(onmusuMarker.getAllMarker());

        model.addAttribute("onmusuMarkers", onmusuList);
        return "map";
    }

}
