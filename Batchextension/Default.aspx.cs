using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Linq;
using System.IO;

public partial class Default : System.Web.UI.Page
{
        string connectionStr = ConfigurationManager.ConnectionStrings["CofferSystemsDB"].ConnectionString;
	protected void Page_Load(object sender, EventArgs e)
	{
		//System.Threading.Thread.Sleep(100);
	}

	protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
	{
		using(SqlConnection con = new SqlConnection(connectionStr))
        {
			DataTable table = new DataTable();
			SqlCommand cmd = new SqlCommand("SELECT id, code, name, transactiontype, description, seggregation, receipt, cheque, amount, date, salereport, crno FROM cashpayment", con);
			SqlDataAdapter data = new SqlDataAdapter(cmd);
			data.Fill(table);

			(sender as RadGrid).DataSource = table;
		}
	}

	protected void RadComboBox1_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
	{
		RadComboBox comboBox = sender as RadComboBox;
		string columnName = e.Context["ColumnName"].ToString();
		string relatedValue = e.Context["RelatedValue"] != null ? e.Context["RelatedValue"].ToString() : "";


		//Retrieve the RadComboBox data, based on the relatedValue and the columnName
		//--------------------------------------------------------
		List<DemoItem> items = new List<DemoItem>();
		if (columnName == "Name")
		{
			using (SqlConnection con = new SqlConnection(connectionStr))
			{
				con.Open();
				SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name , code from subheads where company='" + Application["Company"].ToString() + "' and level='4' order by sub_head ", con);
				SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
				DataSet ds1 = new DataSet();
				da1.Fill(ds1);
				comboBox.DataSource = ds1.Tables[0];
				comboBox.DataTextField = "full_name";
				comboBox.DataValueField = "code";
				comboBox.DataBind();
			}
		}
		else if (columnName == "transactiontype")
		{
			items = DemoRelatedValues.gettransactiontype();
		}
		else if (columnName == "City")
		{
			items = DemoRelatedValues.GetCities(relatedValue);
		}

		if (items.Count > 0)
		{
			foreach (DemoItem item in items)
			{
				comboBox.Items.Add(new RadComboBoxItem(item.Text));
			}
		}
	}

	protected void RadGrid1_BatchEditCommand(object sender, GridBatchEditingEventArgs e)
	{
	}
	protected void ddlName_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
	{
		RadComboBox ddlName = sender as RadComboBox;
		using (SqlConnection con = new SqlConnection(connectionStr))
		{
			con.Open();
			SqlCommand cmd1 = new SqlCommand(@"Select sub_head AS full_name , code from subheads where level='4' order by sub_head ", con);
			SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
			DataSet ds1 = new DataSet();
			da1.Fill(ds1);
			ddlName.DataSource = ds1.Tables[0];
			ddlName.DataTextField = "full_name";
			ddlName.DataValueField = "code";
			ddlName.DataBind();
		}

	}
	protected void ddltransactiontype_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
	{
		RadComboBox ddltransactiontype = sender as RadComboBox;
		ddltransactiontype.Items.Add("DB");
		ddltransactiontype.Items.Add("CR");
	}

	protected void Page_PreRender(object sender, EventArgs e)
    {
        //GridTableView masterTable = RadGrid1.MasterTableView;
        //foreach (GridColumn column in masterTable.RenderColumns)
        //{
        //    if ((column is IGridEditableColumn) && (column as IGridEditableColumn).IsEditable && masterTable.GetBatchColumnEditor(column.UniqueName) != null)
        //    {
        //        Control container = (masterTable.GetBatchColumnEditor(column.UniqueName) as IGridColumnEditor).ContainerControl;
        //        if (container != null && container.Controls.Count > 0)
        //        {
        //            (container.Controls[0] as WebControl).Width = Unit.Percentage(100);
        //        }
        //    }
        //}
    }
    protected void radAjaxMgr_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        //RadGrid1.Rebind();
    }
}


#region dummy-data

public static class DemoRelatedValues
{
	private static List<DemoItem> Continents()
	{
		List<DemoItem> items = new List<DemoItem>();
		items.Add(new DemoItem(1, "North America"));
		items.Add(new DemoItem(2, "Europe"));
		return items;
		//items.FindAll(x => x.Value == 1);
	}

	private static List<DemoItem> gettransactiontype1()
	{
		List<DemoItem> items = new List<DemoItem>();
		items.Add(new DemoItem(1, "DB"));
		items.Add(new DemoItem(2, "CR"));
		return items;
	}

	private static List<DemoItem> Cities()
	{
		List<DemoItem> items = new List<DemoItem>();
		int id = 1;
		int rel = 1;
		//United States
		items.Add(new DemoItem(id++, "Washington", rel));
		items.Add(new DemoItem(id++, "New York", rel));
		items.Add(new DemoItem(id++, "Los Angeles", rel));
		items.Add(new DemoItem(id++, "Chicago", rel));
		items.Add(new DemoItem(id++, "Phoenix", rel));
		items.Add(new DemoItem(id++, "Phoenix", rel));

		//Canada
		rel++;
		items.Add(new DemoItem(id++, "Ottawa", rel));
		items.Add(new DemoItem(id++, "Edmonton", rel));

		//England
		rel++;
		items.Add(new DemoItem(id++, "London", rel));
		items.Add(new DemoItem(id++, "Bristol", rel));
		items.Add(new DemoItem(id++, "Birmingham", rel));
		items.Add(new DemoItem(id++, "Bradford", rel));
		items.Add(new DemoItem(id++, "Canterbury", rel));

		//France
		rel++;
		items.Add(new DemoItem(id++, "Paris", rel));
		items.Add(new DemoItem(id++, "Nice", rel));
		items.Add(new DemoItem(id++, "Caen", rel));
		items.Add(new DemoItem(id++, "Nancy", rel));
		items.Add(new DemoItem(id++, "Créteil", rel));

		//Mexico
		rel++;
		items.Add(new DemoItem(id++, "Guadalajara", rel));
		items.Add(new DemoItem(id++, "Mexico City", rel));
		items.Add(new DemoItem(id++, "Puebla", rel));
		items.Add(new DemoItem(id++, "Tijuana", rel));


		return items;
	}

	public static List<DemoItem> GetContinents()
	{
		return Continents();
	}

	public static List<DemoItem> gettransactiontype()
	{
		return gettransactiontype1().ToList();
	}

	public static List<DemoItem> GetCities(string filterValue)
	{
		return Cities().ToList();
	}
}

public class DemoItem
{
	public int Value { get; set; }
	public string Text { get; set; }
	public int Relation { get; set; }

	public DemoItem(int value, string text, int relation)
	{
		this.Value = value;
		this.Text = text;
		this.Relation = relation;
	}

	public DemoItem(int value, string text)
	{
		this.Value = value;
		this.Text = text;
	}
}

#endregion