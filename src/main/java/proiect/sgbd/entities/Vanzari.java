package proiect.sgbd.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the VANZARI database table.
 * 
 */
@Entity
@NamedQuery(name="Vanzari.findAll", query="SELECT v FROM Vanzari v")
public class Vanzari implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private long id;

	@Temporal(TemporalType.DATE)
	@Column(name="DATA_TRANZACTIE")
	private Date dataTranzactie;

	private BigDecimal total;

	//bi-directional many-to-one association to Bon
	@ManyToOne
	@JoinColumn(name="ID_BON")
	private Bon bon;

	//bi-directional many-to-one association to Client
	@ManyToOne
	@JoinColumn(name="ID_CLIENT")
	private Client client;

	public Vanzari() {
	}

	public long getId() {
		return this.id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Date getDataTranzactie() {
		return this.dataTranzactie;
	}

	public void setDataTranzactie(Date dataTranzactie) {
		this.dataTranzactie = dataTranzactie;
	}

	public BigDecimal getTotal() {
		return this.total;
	}

	public void setTotal(BigDecimal total) {
		this.total = total;
	}

	public Bon getBon() {
		return this.bon;
	}

	public void setBon(Bon bon) {
		this.bon = bon;
	}

	public Client getClient() {
		return this.client;
	}

	public void setClient(Client client) {
		this.client = client;
	}

}