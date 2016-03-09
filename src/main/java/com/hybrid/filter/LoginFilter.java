package com.hybrid.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Servlet Filter implementation class LoginFilter
 */
@WebFilter("") //dept밑으로 모든 파일에 필터 적용
public class LoginFilter implements Filter {

    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	
	static Log log = LogFactory.getLog(LoginFilter.class);
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

	
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		String accept = req.getHeader("Accept");
		
		log.info("requestURI = "+ req.getRequestURI());
		log.info("Accept = "+ accept);
		if(accept.indexOf("application/json")== -1){
			chain.doFilter(request, response); //요청 URL에 대해 수행한다.
			// 로그인이 되었다면 처리
		}else{
			//로그인 안되었다면
			PrintWriter out = res.getWriter();
			String json = "{\"login\" : false}";
			out.println(json);
		}
		
		
		
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
