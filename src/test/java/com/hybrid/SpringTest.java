package com.hybrid;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.hybrid.shape.Shape;



/**
 * Hello world!
 *
 */
public class SpringTest 
{
	
	static Log log = LogFactory.getLog(SpringTest.class);
	
	Shape s;
	Shape s1;
	
	SimpleDateFormat dateFormat;
	
	public void setDateFormat(SimpleDateFormat df){
		this.dateFormat = df;
	}
	
	
	public SpringTest(){
		log.info("SpringTest()");
	}
	
	public void setShape(Shape s){
		log.info("setShape()");
		this.s = s;
	}
	
	public void setShape1(Shape s1){
		log.info("setShape1()");
		this.s1 = s1;
	}
	
	public void print(){
		log.info("s.width = " +s.getWidth());
    	log.info("s.Height = " +s.getHeight());
    	log.info("s.Color = " +s.getColor());
    	log.info("s.date = " +dateFormat.format(s.getDate()));
    	
    	log.info("s1.width = " +s1.getWidth());
    	log.info("s1.Height = " +s1.getHeight());
    	log.info("s1.Color = " +s1.getColor());
    	log.info("s1.date = " +dateFormat.format(s1.getDate()));
	}
	
    public static void main( String[] args )
    {
    	GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("spring/beans.xml");
    	// 설정파일을 ctx(별칭)라는 프레임워크(기본구조틀)에 적용한다.
    	
    	//Shape s = ctx.getBean(Shape.class);
    	//getBean 공장(Shape.java)에 있는 값들을 가져온다.
    	//Shape 는 beans.xml에 의해 자동으로 객체가 생성되고 값이 주입된 상태이다.
    	
    	SpringTest spring = ctx.getBean(SpringTest.class);// 에러가난다. 공장에는 beans설정을 갖은 springTest가 없기때문
    	spring.print();
    	
    	
    	ctx.close();
    }
}

