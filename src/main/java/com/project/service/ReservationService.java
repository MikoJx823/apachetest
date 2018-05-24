package com.project.service;

import java.net.Inet4Address;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.log4j.Logger;

import com.project.bean.OrderBean;
import com.project.bean.OrderItemBean;
import com.project.pulldown.OrderStatusPulldown;
import com.project.util.PropertiesUtil;
import com.project.util.StaticValueUtil;

public class ReservationService
{
	static Logger logger = Logger.getLogger(ReservationService.class);

	private static ReservationService instance = null;

	public static synchronized ReservationService getInstance()
	{
		if (instance == null)
			instance = new ReservationService();
		return instance;
	}

	private ReservationService()
	{}

	private static final int DEFAULT_PROCESS_SLEEP_TIME_SEC = 5;

	// Session Id, holdingItem
	private static HashMap<String, HashMap<String, Item>> holdingItem = new HashMap<String, HashMap<String, Item>>();
	private static Date lastProcessReleaseTime = null;
	
	public static HashMap<String, Integer> getSessionToQtyMap(Integer itemId)
	{
		HashMap<String, Integer> sessionToQtyMap = new HashMap<String, Integer>();

		Set<String> keySet = holdingItem.keySet();
		Iterator<String> itr = keySet.iterator();
		HashMap<String, Item> items = null;
		Item item = null;
		String sessionId = null;

		while (itr.hasNext())
		{
			sessionId = itr.next();
			items = holdingItem.get(sessionId);

			item = items.get(itemId);
			if (item != null)
			{
				sessionToQtyMap.put(sessionId, item.getHoldQuantity());
			}
		}

		return sessionToQtyMap;
	}

	private class Item{

		int itemId;
		String itemIdStr;
		Date startHoldingTime;
		int holdQuantity;

		public Date getStartHoldingTime()
		{
			return startHoldingTime;
		}

		public void setStartHoldingTime(Date startHoldingTime)
		{
			this.startHoldingTime = startHoldingTime;
		}

		public int getHoldQuantity()
		{
			return holdQuantity;
		}

		public void setHoldQuantity(int holdQuantity)
		{
			this.holdQuantity = holdQuantity;
		}

		public int getItemId()
		{
			return itemId;
		}

		public void setItemId(int itemId)
		{
			this.itemId = itemId;
		}

		public String getItemIdStr() {
			return itemIdStr;
		}

		public void setItemIdStr(String itemIdStr) {
			this.itemIdStr = itemIdStr;
		}
	}
	
	// SESSION - object
	private class HoldingSession{
		Date startHoldingTime;
		String sessionId;
		String clientIpAddress;

		public Date getStartHoldingTime(){
			return startHoldingTime;
		}

		public void setStartHoldingTime(Date startHoldingTime){
			this.startHoldingTime = startHoldingTime;
		}

		public String getSessionId(){
			return sessionId;
		}

		public void setSessionId(String sessionId){
			this.sessionId = sessionId;
		}

		public String getClientIpAddress() {
			return clientIpAddress;
		}

		public void setClientIpAddress(String clientIpAddress) {
			this.clientIpAddress = clientIpAddress;
		}
	}
	
	// temporary hold the seat (in session only) - NORMAL ITEM 
	public synchronized boolean holdItem(String sessionId, OrderItemBean cart, boolean isUpdateHoldTime)
	{
		boolean result = false;

		if (sessionId == null || cart == null)
		{
			return result;
		}

		// *************
		// get items for this session id
		// *************
		int itemId = 0;
		int availableQty = 0;
		int holdQty = 0;
		try
		{
			HashMap<String, Item> items = holdingItem.get(sessionId);
			Item item = null;
			if (items == null)
			{
				// no item hold in this session
				items = new HashMap<String, Item>();
			}

				
			itemId = cart.getPvid();
			holdQty = cart.getQuantity();
			
			logger.info("itemId:" + itemId);
			logger.info("holdQty:" + holdQty);

			// ***********************
			// get item available qty
			// ***********************
			ProductService proServ = ProductService.getInstance();
			availableQty = proServ.getProductAvailableQuantity(itemId);
			
			logger.info("cart id " + cart.getId());
			logger.info("available Qty " + availableQty);
			// ***********************
			// get qty hold by other customer (in the session, clp want to do check during payment)
			// ***********************
			//int heldQty = getQtyHeld(itemPrefix + itemId);
			int heldQty = 0;
			
			// *************
			// check if this item is first hold
			// *************

			boolean isFirstHold = true;
			Item oldItem = items.get(itemId);
			if (oldItem == null)
			{
				isFirstHold = true;
			} else
			{	
				heldQty = oldItem.getHoldQuantity();
				isFirstHold = false;
			}

			if (isFirstHold)
			{ // first time add this item
				// *************
				// check if item can be hold
				// *************
				if (holdQty > availableQty - heldQty)
				{
					// cannot hold
					result = false;
					logger.info("Hold item fail: not enough stock - productvariant id = " + cart.getPvid() + ", hold qty = " + holdQty + " [Session Id: " + sessionId + "]");
				} else
				{
					// can hold
					item = new Item();
					item.setStartHoldingTime(Calendar.getInstance().getTime());
					item.setHoldQuantity(cart.getQuantity());

					// add
					items.put(itemId + "", item);

					// put to global holding object
					holdingItem.put(sessionId, items);

					result = true;
					logger.info("Hold item: productvariant code = " + cart.getPvid() + ", hold qty = " + holdQty + " [Session Id: " + sessionId + "]");
				}
			} else
			{ // customer already added this item, update quantity
				int oldHeldQty = oldItem.getHoldQuantity();

				// *************
				// check if item can be hold
				// *************
				if (holdQty > availableQty - heldQty + oldHeldQty)
				{
					// cannot hold
					result = false;
					logger.info("Hold item fail: not enough stock - productvariant code = " + cart.getPvid() + ", hold qty (old) = " + oldHeldQty + " hold qty (new) = " + holdQty + " [Session Id: "
							+ sessionId + "]");
				} else
				{
					oldItem.setHoldQuantity(holdQty);
					if (isUpdateHoldTime)
					{
						oldItem.setStartHoldingTime(Calendar.getInstance().getTime());
					}

					// put back
					items.put(itemId + "", oldItem);

					// put to global holding object
					holdingItem.put(sessionId, items);

					result = true;
					logger.info("Hold item: productvariant = " + cart.getPvid() + ", hold qty (old) " + oldHeldQty + ", hold qty (new) = " + holdQty + " [Session Id: " + sessionId + "]");
				}
			}

		} catch (Exception e)
		{
			logger.error("Process item hold fail: [Session Id: " + sessionId + "]");
			logger.error(e.getMessage(), e);
		}

		return result;
	}
	
	public int getQtyHeld(String itemId)
	{
		Set<String> keySet = holdingItem.keySet();
		Iterator itr = keySet.iterator();
		HashMap items = null;
		Item item = null;
		String sessionId = null;
		int qtyHeld = 0;

		while (itr.hasNext())
		{
			sessionId = (String) itr.next();
			items = holdingItem.get(sessionId);

			item = (Item) items.get(itemId);
			if (item != null)
			{
				qtyHeld += item.getHoldQuantity();
			}
		}
		return qtyHeld;
	}

	/**
	 * Get item quantity held by this session id
	 * 
	 * @param itemId
	 * @param a_sessionId
	 * @return
	 */
	public int getQtyHeld(int itemId, String a_sessionId)
	{
		Set<String> keySet = holdingItem.keySet();
		Iterator itr = keySet.iterator();
		HashMap items = null;
		Item item = null;
		String sessionId = null;
		int qtyHeld = 0;

		while (itr.hasNext())
		{
			sessionId = (String) itr.next();
			if (sessionId != null && sessionId.equals(a_sessionId))
			{
				items = holdingItem.get(sessionId);

				item = (Item) items.get(itemId);
				if (item != null)
				{
					qtyHeld += item.getHoldQuantity();
				}
			}
		}
		return qtyHeld;
	}
	
	
	public synchronized void releaseSessionItem(String sessionId, String itemId)
	{
		if (holdingItem.containsKey(sessionId))
		{
			HashMap items = holdingItem.get(sessionId);
			Item item = (Item) items.get(itemId);
			if (item != null)
			{
				items.remove(itemId);
			}
		}
	}
	
	public synchronized void releaseSession(String sessionId)
	{
		if (holdingItem.containsKey(sessionId))
		{
			holdingItem.remove(sessionId);
		}
	}
	
	/**
	 * Release all items held by all sessions
	 * 
	 * @return
	 */
	public synchronized boolean releaseAllHoldings()
	{
		try
		{
			if (holdingItem != null)
			{
				holdingItem.clear();
				logger.info("Release all item holding");
				return holdingItem.isEmpty();
			} else
			{
				logger.error("Release all item holding (FAIL): holding object is null");
				return false;
			}
		} catch (Exception e)
		{
			logger.error("Release all item holding (FAIL)");
			logger.error(e.getMessage(), e);
		}
		return false;
	}

	// check holding seat and release all
	public synchronized void releaseHoldingItem()
	{
		Date now = Calendar.getInstance().getTime();
		ArrayList<String> toBeRemoved = new ArrayList<String>();

		// get max hold time
		int sessionExpireTimeSec;
		String sessionExpireTime = null;
		try
		{
			sessionExpireTime = PropertiesUtil.getProperty("stockhold.sessionExpireTime");
			sessionExpireTimeSec = Integer.parseInt(sessionExpireTime);
		} catch (Exception e)
		{
			sessionExpireTimeSec = 1800;
		}

		HashMap items = null;
		Item item = null;
		String sessionId = null;
		String itemId = null;
		//Integer itemId = null;
		int qtyHeld = 0;

		try
		{
			Set<String> keySet = holdingItem.keySet();
			Iterator itr = keySet.iterator();
			while (itr.hasNext())
			{
				sessionId = (String) itr.next();
				items = holdingItem.get(sessionId);
				Set<String> keySet2 = items.keySet();
					
				Iterator itr2 = keySet2.iterator();
				while (itr2.hasNext())
				{
					//logger.info(itr2.next() );
					itemId = (String) itr2.next();	
					item = (Item) items.get(itemId);

					if (now.getTime() - item.getStartHoldingTime().getTime() > (1000 * sessionExpireTimeSec)){
						toBeRemoved.add(sessionId);
					}	
				}
			}

			for (String sessionIdToBeRemove : toBeRemoved)
			{
				releaseSession(sessionIdToBeRemove);
			}

		} catch (Exception e)
		{
			// checking error
			logger.error("Process release holding item fail");
		}
	}

	/**
	 * Reject pending transaction which last longer than specific time (defined
	 * in ocl.properties key=stockhold.sessionExpireTime)
	 * 
	 * @return html process log
	 */
	public synchronized void rejectPendingOrder()
	{
		logger.info("******************* START rejectPendingOrder ******************** ");
		
		Date now = Calendar.getInstance().getTime();
		List<OrderBean> orders = new ArrayList<OrderBean>();
		int rs = 0;
		int rs2 = 0;
		int rs3 = 0;

		try
		{
			// get max hold time
			
			logger.info("ip : " + Inet4Address.getLocalHost().getHostAddress());
			
			int sessionExpireTimeSec;
			String sessionExpireTime = null;
			try
			{
				sessionExpireTime = PropertiesUtil.getProperty("stockhold.sessionExpireTime");
				sessionExpireTimeSec = Integer.parseInt(sessionExpireTime);
			} catch (Exception e)
			{
				sessionExpireTimeSec = 1800;
			}

			OrderService orderServ = OrderService.getInstance();
			long currentTime = Calendar.getInstance().getTimeInMillis();
			long tranCreationTime = 0;
			String newOrderStatus = OrderStatusPulldown.REJECTED;
			String updateBy = "System:Rejected";

			//orders = orderServ.getOrderMainListByStatus(OrderStatusPulldown.PENDING);
			orders = orderServ.getListByStatusForReserveService();
			logger.info("ORDERS : " + orders.size());
			for (OrderBean order : orders)
			{
				if (order != null)
				{

					try
					{

						tranCreationTime = order.getCreatedDate().getTime();
						
						if (OrderStatusPulldown.PENDING.equals(order.getOrderStatus()) && (currentTime >= tranCreationTime + sessionExpireTimeSec * 1000))
						{

							// reject expired pending transaction
							order.setOrderStatus(newOrderStatus);
							order.setModifiedBy(updateBy);

							// *************
							// Update transaction record
							// *************
							orderServ.updateOrderStatus(order);

						}
					} catch (Exception e)
					{
						// cannot reject expired pending transaction
						logger.error("Process reject pending transaction fail: Order ID = " + order.getoId() + " ["+e.toString()+"]");
						e.printStackTrace();
						logger.error(e.getStackTrace());
					}
				}
			}
		} catch (Exception e)
		{
			// checking error
			logger.error("Process reject pending transaction fail");
			logger.error(e.getMessage(), e);
		}
		
		logger.info("******************* END rejectPendingOrder **************** ");
	}
	
	
	public static String printHoldStatus()
	{
		StringBuffer sb = new StringBuffer();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		sb.append("<br />");
		sb.append("============ ocl stock hold status ==============");
		sb.append("<br />");
		sb.append("System time: " + sdf.format(Calendar.getInstance().getTime()));
		sb.append("<br />");
		sb.append("Last process release time: " + (lastProcessReleaseTime == null ? "" : sdf.format(lastProcessReleaseTime)) + ", process run interval: " + ReservationService.getProcessSleepTime()
				+ " second");

		sb.append("<br />");
		if (holdingItem == null)
		{
			sb.append("holdingItem Object is null");
		}
		sb.append("<br />");
		sb.append("<br />");

		Set<String> keySet = holdingItem.keySet();
		Iterator itr = keySet.iterator();
		Item item = null;
		HashMap items = null;
		String sessionId = null;

		while (itr.hasNext())
		{
			sessionId = (String) itr.next();
			sb.append("Sid = " + sessionId + "");
			sb.append("<br />");

			items = holdingItem.get(sessionId);

			Set<Integer> keySet2 = items.keySet();
			Iterator itr2 = keySet2.iterator();
			int itemId;
			while (itr2.hasNext())
			{
				itemId = (Integer) itr2.next();
				item = (Item) items.get(itemId);
				sb.append(" Item Id = " + itemId + " Qty = " + item.getHoldQuantity() + " hold time = " + sdf.format(item.getStartHoldingTime()));
				sb.append("<br />");
			}

			sb.append("<br />");
			sb.append("<br />");
		}
		return sb.toString();
	}

	static
	{
		logger.info("start");
		//ReleaseProcess process = ReservationService.getInstance().new ReleaseProcess();
		//Thread releaseProcess = new Thread(process);
		//releaseProcess.start();
		
		Thread releaseProcess = new Thread(){
    	    public void run(){
    	    	while (true)
    			{			
    				logger.info("ReleaseProcess start");
    				try
    				{
    					lastProcessReleaseTime = Calendar.getInstance().getTime();

    					int processSleepTimeSec = ReservationService.getProcessSleepTime();

    					ReservationService.getInstance().releaseHoldingItem();
    					ReservationService.getInstance().rejectPendingOrder();
    					//ReservationService.getInstance().releaseHoldingSession();

    					Thread.sleep(1000 * processSleepTimeSec);

    				} catch (Exception e)
    				{
    					try
    					{
    						Thread.sleep(1000 * DEFAULT_PROCESS_SLEEP_TIME_SEC);
    					} catch (InterruptedException e1)
    					{
    						// Thread sleep error
    					}
    				}
    				logger.info("ReleaseProcess end");
    			}
    	    }
    	};
    	
		releaseProcess.start();
		logger.info("end");
	}

	public class ReleaseProcess implements Runnable
	{

		public void run()
		{

			while (true)
			{			
				logger.info("ReleaseProcess start");
				try
				{
					lastProcessReleaseTime = Calendar.getInstance().getTime();

					int processSleepTimeSec = ReservationService.getProcessSleepTime();

					ReservationService.getInstance().releaseHoldingItem();
					ReservationService.getInstance().rejectPendingOrder();

					// System.out.println("ReservationService.ReleaseProcess:  completed at: "
					// + new Date());
					Thread.sleep(1000 * processSleepTimeSec);

				} catch (Exception e)
				{
					try
					{
						// System.out.println("ReleaseProcess error: " + e);
						Thread.sleep(1000 * DEFAULT_PROCESS_SLEEP_TIME_SEC);
					} catch (InterruptedException e1)
					{
						// TODO Auto-generated catch block
						// Thread sleep error
					}
				}
				logger.info("ReleaseProcess end");
			}
		}
	}

	private static int getProcessSleepTime()
	{
		String processSleepTime = null;
		int processSleepTimeSec;
		try
		{
			processSleepTime = PropertiesUtil.getProperty("stockhold.releaseProcessSleepTime");
			processSleepTimeSec = Integer.parseInt(processSleepTime);
		} catch (Exception e)
		{
			processSleepTimeSec = DEFAULT_PROCESS_SLEEP_TIME_SEC;
		}
		return processSleepTimeSec;
	}

}
