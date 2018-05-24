package com.project.service;


import org.apache.log4j.Logger;

import com.project.dao.SeqDao;

public class SeqService {
	
	Logger log = Logger.getLogger(SeqService.class);

	private static SeqService instance = null;
	private SeqDao seqDao;
	
	public static synchronized SeqService getInstance()
	{
		if (instance == null)
			instance = new SeqService();
		return instance;
	}
	private SeqService()
	{
		seqDao = SeqDao.getInstance();
	}
	
	public int getSeqid()
	{
		return  seqDao.getSeqid();
	}
	
	

}
