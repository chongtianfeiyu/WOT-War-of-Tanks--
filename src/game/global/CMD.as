package game.global
{
	/**
	 * 按照功能来分
	 */
	public class CMD
	{
		public function CMD()
		{
			
		}
		
		public static const SHOW_LOGIN:String = "_show_login";
		public static const SHOW_LOBBY:String = "_show_lobby";
		public static const SHOW_BATTLE:String = "_show_battle";
		public static const GAME_OVER:String = "_show_game_over";
		
		public static const TANK_HP:String = "_tank_hp"; 
		public static const TANK_SHOOT:String = "_tank_shoot";
		public static const TANK_MOVE:String = "_tank_move";
		public static const TANK_INIT:String = "_tank_init";
		public static const TANK_STOP:String = "_tank_stop";
		public static const TANK_KILLS:String = "_tank_kills";
		
		public static const LOAD_LOBBY:String = "_load_lobby";
		public static const LOAD_BATTLE:String = "_load_battle";
		public static const UPDATE_MINI_MAP:String = "_update_mini_map";
		public static const BACK_TO_LOBBY:String = "_back_to_lobby";
		
		public static const SWITCH_WAITTING:String = "_switch_waitting";
		public static const SWITCH_LOBBY:String = "_switch_lobby";
		public static const SWITCH_PANEL:String = "_switch_panel";
		
		public static const SET_UP_CONFIG:String = "_set_up_config";
		
		public static const NET_CONNECT:String = "_net_connect";
		public static const NET_LOGIN:String = "_net_login";
		public static const NET_JOIN_LOBBY:String = "_net_join_lobby";
		public static const NET_CREATE_GAME_ROOM:String = "_net_create_game_room";
		public static const NET_QUICK_GAME:String = "_net_quick_game";
		public static const NET_JOIN_GAME:String = "_net_join_game";
		public static const NET_LEAVE_GAME:String = "_net_leave_game";
		public static const NET_LEAVE_LOBBY:String = "_net_leave_lobby";
		public static const NET_SEND_CHAT:String = "_net_send_chat";
		public static const NET_SEND_INIT:String = "_net_send_init";
		public static const NET_SEND_MOVE:String = "_net_send_move";
		public static const NET_SEND_SHOOT:String = "_net_send_shoot";
		public static const NET_SEND_STOP:String = "_net_send_stop";
		public static const NET_SEND_HP:String = "_net_send_hp";
		public static const NET_SEND_KILLED:String = "_net_send_killed";
		public static const NET_SET_GAME_STATE:String = "_net_set_game_state";
		
		public static const BUY_NEW_TANK:String = "_buy_new_tank";
		public static const SET_MAIN_TANK:String = "_set_main_tank";
		public static const DESTORY_TANK:String = "_destory_tank";
		public static const ON_SET_MAIN_TANK:String = "_on_set_main_tank";
		public static const ON_DESTORY_TANK:String = "_on_destory_tank";
		
		public static const ADD_ITEM:String = "_add_item";
		public static const USE_ITEM:String = "_use_item";
		public static const ON_ITEM_CHANGE:String = "_on_item_change";
		
		public static const TIP_GET_ITEMS:String = "_tip_get_items";
		
		public static const SHOW_LOAD_TIP:String = "_show_load_tip";
		public static const REMOVE_LOAD_TIP:String = "_remove_load_tip";
		
	}
}