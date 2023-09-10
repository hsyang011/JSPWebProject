package market;

public class BasketDTO {

	private String num;
	private String id;
	private String selected_quantity;
	private String total_price;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSelected_quantity() {
		return selected_quantity;
	}
	public void setSelected_quantity(String selected_quantity) {
		this.selected_quantity = selected_quantity;
	}
	public String getTotal_price() {
		return total_price;
	}
	public void setTotal_price(String total_price) {
		this.total_price = total_price;
	}
	
}
