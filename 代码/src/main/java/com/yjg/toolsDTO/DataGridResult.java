package com.yjg.toolsDTO;

import java.util.List;
/**
 * 分页返回类，用于easyui请求数据的响应
 * */
public class DataGridResult {

	private Integer total;

	private List<?> rows;

	public DataGridResult(Integer total, List<?> rows) {
		this.total = total;
		this.rows = rows;
	}

	public DataGridResult(long total, List<?> rows) {
		this.total = (int) total;
		this.rows = rows;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}
}
