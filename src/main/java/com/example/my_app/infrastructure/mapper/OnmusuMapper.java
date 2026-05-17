package com.example.my_app.infrastructure.mapper;

import com.example.my_app.infrastructure.entity.Onmusu;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface OnmusuMapper {

    List<Onmusu> selectAll();

}
