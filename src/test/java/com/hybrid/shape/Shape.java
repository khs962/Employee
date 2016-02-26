package com.hybrid.shape;

import java.util.Date;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Shape {
	static Log log =LogFactory.getLog(Shape.class);
	
	int width;
	int height;
	int color;
	
	Date date;
	
	public Shape(int width, int height, int color){
		log.info("shape(" +width + ", "+height+", "+color+")");
		this.width=width;
		this.height=height;
		this.color=color;
		
		//this.date=date;
	}
	
	
	public Shape(){
		log.info("Shape()");
	}
	public int getWidth() {
		log.info("getWidth()");
		return width;
	}
	public void setWidth(int width) {
		log.info("setWidth()");
		this.width = width;
	}
	public int getHeight() {
		log.info("getHeigth()");
		return height;
	}
	public void setHeight(int height) {
		log.info("setHeigth()");
		this.height = height;
	}
	public int getColor() {
		log.info("getColor()");
		return color;
	}
	public void setColor(int color) {
		log.info("setColor()");
		this.color = color;
	}

	public Date getDate() {
		log.info("getDate()");
		return date;
	}

	public void setDate(Date date) {
		log.info("setDate(");
		this.date = date;
	}
	
	
	
}
