package com.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.controller.Action;
import com.shop.controller.ActionForward;
import com.shop.model.CategoryDAO;
import com.shop.model.CategoryDTO;
import com.shop.model.ProductDAO;
import com.shop.model.ProductDTO;

public class AdminProductUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// get 방식으로 넘어온 상품 번호에 해당하는 상품의 상세 내역을
		// 조회하여 수정 폼 페이지로 상세 내역을 전달하는 비지니스 로직.
		
		int product_num = Integer.parseInt(request.getParameter("pnum").trim());
		
		ProductDAO dao = ProductDAO.getInstance();
		ProductDTO dto = dao.productCont(product_num);
		
		CategoryDAO cdao = CategoryDAO.getInstance();
		List<CategoryDTO> list = cdao.getCategoryList();
		
		request.setAttribute("productDto", dto);
		request.setAttribute("categoryList", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("admin/admin_product_update.jsp");
		
		
		return forward;
		
	}

}
