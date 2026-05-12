package com.example.my_app.presentation.mapper;

import com.example.my_app.infrastructure.entity.Onmusu;
import com.example.my_app.presentation.dto.OnmusuResponse;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;

import java.net.MalformedURLException;
import java.net.URI;
import java.util.List;

@Mapper(componentModel = "spring")
public interface OnmusuMapper {

    OnmusuResponse toResponse(Onmusu onmusu);
    List<OnmusuResponse> toResponseList(List<Onmusu> onmusuList);

}
