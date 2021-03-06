/* zeitgeist-2.0.vapi generated by valac 0.30.0, do not modify. */

/**
 * Zeitgeist is an activity-logging framework to enable the desktop of
 * the future.
 *
 * Its main component is the Zeitgeist engine, a D-Bus service that logs
 * any events other applications send to it. An event may be anything like:
 *  - The user opened/created/modified/closed a file, or visited a website.
 *  - The user received an e-mail, a phone call or an IM notification.
 *  - Someone modified a remote (eg. Google Drive) document owned by the user.
 *
 * This information is then made available to other Zeitgeist-enabled
 * applications over a powerful querying and monitoring API, and can be used
 * and analyzed to create intelligent or adaptive interfaces.
 *
 * Zeitgeist also comes with a blacklist extension to make sure the user
 * always stays in control of what information is logged.
 */
namespace Zeitgeist {
	/**
	 * Query the Zeitgeist Data-Source Registry extension
	 *
	 * The Zeitgeist engine maintains a publicly available list of recognized
	 * data-sources (components inserting information into Zeitgeist).
	 * ZeitgeistDataSourceRegistry is used to register new data sources,
	 * get information about them and gives the ability to enable or disable
	 * the data sources.
	 */
	[CCode (cheader_filename = "zeitgeist.h")]
	public class DataSourceRegistry : Zeitgeist.QueuedProxyWrapper {
		public DataSourceRegistry ();
		public async Zeitgeist.DataSource get_data_source_from_id (string unique_id, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public async GLib.GenericArray<Zeitgeist.DataSource> get_data_sources (GLib.Cancellable? cancellable = null) throws GLib.Error;
		protected override void on_connection_established ();
		protected override void on_connection_lost ();
		public async bool register_data_source (Zeitgeist.DataSource data_source, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public async void set_data_source_enabled (string unique_id, bool enabled, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public signal void source_disconnected (Zeitgeist.DataSource data_source);
		public signal void source_enabled (string unique_id, bool enabled);
		public signal void source_registered (Zeitgeist.DataSource data_source);
	}
	/**
	 * Query the Zeitgeist Full Text Search Extension
	 *
	 * include: zeitgeist.h
	 */
	[CCode (cheader_filename = "zeitgeist.h")]
	public class Index : Zeitgeist.QueuedProxyWrapper {
		/**
		 * Create a new index that interfaces with the default event index of the
		 * Zeitgeist daemon.
		 *
		 * Create a new {@link Index} instance. The index will start to connect
		 * to Zeitgeist asynchronously. You can however start calling methods on
		 * the returned instance immediately, any method calls issued before the
		 * connection has been established will simply be queued and executed once
		 * the connection is up.
		 *
		 * Returns: A reference to a newly allocated index. Free with g_object_unref().
		 */
		public Index ();
		protected override void on_connection_established ();
		protected override void on_connection_lost ();
		/**
		 * Perform a full text search possibly restricted to a {@link TimeRange}
		 * and/or set of event templates.
		 *
		 * The default boolean operator is %AND. Thus the query
		 * //foo bar// will be interpreted as //foo AND bar//. To exclude a term
		 * from the result set prepend it with a minus sign - eg. //foo -bar//.
		 * Phrase queries can be done by double quoting the string
		 * //"foo is a bar"//. You can truncate terms by appending a *.
		 *
		 * There are a few keys you can prefix to a term or phrase to search within
		 * a specific set of metadata. They are used like //key:value//. The keys
		 * //name// and //title// search strictly within the text field of the
		 * event subjects. The key //app// searches within the application name or
		 * description that is found in the actor attribute of the events. Lastly,
		 * you can use the //site// key to search within the domain name of subject
		 * URIs.
		 *
		 * You can also control the results with the boolean operators //AND// and
		 * //OR// and you may use brackets, ( and ), to control the operator
		 * precedence.
		 *
		 * FIXME: how do we put documentation into _finish?
		 * The total hit count of the query will be available via the returned
		 * result set by calling zeitgeist_result_set_estimated_matches(). This will
		 * often be bigger than the actual number of events held in the result set,
		 * which is limited by the @num_events parameter passed to
		 * zeitgeist_index_search().
		 *
		 * @param query The search string to send to Zeitgeist
		 * @param time_range Restrict matched events to ones within this time
		 *     range. If you are not interested in restricting the timerange pass
		 *     zeitgeist_time_range_new_anytime() as Zeitgeist will detect
		 *     this and optimize the query accordingly
		 * @param event_templates Restrict matches events to ones matching these
		 *     templates
		 * @param offset Offset into the result set to read events from
		 * @param num_events Maximal number of events to retrieve
		 * @param result_type The {@link ResultType} determining the sort order.
		 *     You may pass {@link ResultType.RELEVANCY} to this
		 *     method to have the results ordered by relevancy calculated
		 *     in relation to @query
		 * @param cancellable A {@link GLib.Cancellable} used to cancel the
		 *     call or %NULL
		 */
		public async Zeitgeist.ResultSet search (string query, Zeitgeist.TimeRange time_range, GLib.GenericArray<Zeitgeist.Event> event_templates, uint32 offset, uint32 num_events, Zeitgeist.ResultType result_type, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Perform a full text search possibly restricted to a {@link TimeRange}
		 * and/or set of event templates. As opposed to zeitgeist_index_search(),
		 * this call will also return numeric relevancies of the events
		 * in the {@link ResultSet}.
		 *
		 * See zeitgeist_index_search() for more details on how to create the
		 * query.
		 *
		 * @param query The search string to send to Zeitgeist
		 * @param time_range Restrict matched events to ones within this time
		 *     range. If you are not interested in restricting the timerange pass
		 *     zeitgeist_time_range_new_anytime() as Zeitgeist will detect
		 *     this and optimize the query accordingly
		 * @param event_templates Restrict matched events to ones matching these
		 *     templates
		 * @param storage_state Filter the events by availability of the storage
		 *     medium.
		 * @param offset Offset into the result set to read events from
		 * @param num_events Maximal number of events to retrieve
		 * @param result_type The {@link ResultType} determining the sort order
		 *     You may pass {@link ResultType.RELEVANCY} to this method to
		 *     have the results ordered by relevancy calculated in relation
		 *     to "query"
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 *
		 * @param relevancies numeric relevancies of the events returned by result_set
		 * @return {@link ResultSet} result_set.
		 */
		public async Zeitgeist.ResultSet search_with_relevancies (string query, Zeitgeist.TimeRange time_range, GLib.GenericArray<Zeitgeist.Event> event_templates, Zeitgeist.StorageState storage_state, uint32 offset, uint32 num_events, Zeitgeist.ResultType result_type, GLib.Cancellable? cancellable = null, out double[] relevancies) throws GLib.Error;
	}
	/**
	 * Primary access point for talking to the Zeitgeist daemon
	 *
	 * {@link Log} encapsulates the low level access to the Zeitgeist daemon.
	 * You can use it to manage the log by inserting and deleting entries as well
	 * as do queries on the logged data.
	 *
	 * It's important to realize that the #ZeitgeistLog class does not expose
	 * any API that does synchronous communications with the message bus -
	 * everything is asynchronous. To ease development some of the methods have
	 * variants that are "fire and forget" ignoring the normal return value, so
	 * that callbacks does not have to be set up.
	 */
	[CCode (cheader_filename = "zeitgeist.h")]
	public class Log : Zeitgeist.QueuedProxyWrapper {
		public Log ();
		/**
		 * Gets datapath of the running Zeitgeist daemon.
		 *
		 * @return string datapath
		 */
		public string datapath ();
		/**
		 * Delete a collection of events from the zeitgeist log given their event ids.
		 *
		 * The deletion will be done asynchronously, and this method returns immediately.
		 *
		 * @param event_ids Array<uint32>
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async Zeitgeist.TimeRange delete_events (GLib.Array<uint32> event_ids, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Send a query matching a collection of {@link Event} templates to the {@link Log}.
		 * The query will match if an event matches any of the templates. If an event
		 * template has more than one {@link Subject} the query will match if any one
		 * of the {@link Subject}s templates match.
		 *
		 * The query will be done via an asynchronous DBus call and this method will
		 * return immediately. The return value will be passed to callback as a list
		 * of intergers represrting {@link Event} id's.
		 * This list must be the sole argument for the callback.
		 *
		 * In order to use this method there needs to be a mainloop runnning.
		 * Both Qt and GLib mainloops are supported.
		 *
		 * @param time_range {@link TimeRange} A time range in which the events should be considered in
		 * @param storage_state {@link StorageState} storage state
		 * @param event_templates An {@link GLib.GenericArray} of {@link Event}
		 * @param num_events int represteing the number of events that should be returned
		 * @param result_type {@link ResultType} how the events should be grouped and sorted
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async uint32[] find_event_ids (Zeitgeist.TimeRange time_range, GLib.GenericArray<Zeitgeist.Event> event_templates, Zeitgeist.StorageState storage_state, uint32 num_events, Zeitgeist.ResultType result_type, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Send a query matching a collection of {@link Event} templates to the {@link Log}.
		 * The query will match if an event matches any of the templates. If an event
		 * template has more than one {@link Subject} the query will match if any one
		 * of the {@link Subject}s templates match.
		 *
		 * The query will be done via an asynchronous DBus call and this method will
		 * return immediately. The return value will be passed to callback as a list
		 * of {@link Event}s. This list must be the sole argument for the callback.
		 *
		 * If you need to do a query yielding a large (or unpredictable) result set
		 * and you only want to show some of the results at the same time (eg., by
		 * paging them), consider using {@link find_event_ids}.
		 *
		 * In order to use this method there needs to be a mainloop runnning.
		 * Both Qt and GLib mainloops are supported.
		 *
		 * @param time_range {@link TimeRange} A time range in which the events should be considered in
		 * @param storage_state {@link StorageState} storage state
		 * @param event_templates An {@link GLib.GenericArray} of {@link Event}
		 * @param num_events int represteing the number of events that should be returned
		 * @param result_type {@link ResultType} how the events should be grouped and sorted
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async Zeitgeist.ResultSet find_events (Zeitgeist.TimeRange time_range, GLib.GenericArray<Zeitgeist.Event> event_templates, Zeitgeist.StorageState storage_state, uint32 num_events, Zeitgeist.ResultType result_type, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Get a list of URIs of subjects which frequently occur together with events
		 * matching event_templates. Possibly restricting to time_range or to URIs
		 * that occur as subject of events matching result_event_templates.
		 *
		 * @param time_range {@link TimeRange} A time range in which the events should be considered in
		 * @param storage_state {@link StorageState} storage state
		 * @param event_templates An {@link GLib.GenericArray} of {@link Event} describing the events to relate to
		 * @param result_event_templates An {@link GLib.GenericArray} of {@link Event} desrcibing the result to be returned
		 * @param num_events int represteing the number of events that should be returned
		 * @param result_type {@link ResultType} how the events should be grouped and sorted
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async string[] find_related_uris (Zeitgeist.TimeRange time_range, GLib.GenericArray<Zeitgeist.Event> event_templates, GLib.GenericArray<Zeitgeist.Event> result_event_templates, Zeitgeist.StorageState storage_state, uint32 num_events, Zeitgeist.RelevantResultType result_type, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Get a unique instance of #ZeitgeistLog, that you can share in your
		 * application without caring about memory management.
		 *
		 * See zeitgeist_log_new() for more information.
		 *
		 * @return ZeitgeistLog.
		 */
		public static Zeitgeist.Log get_default ();
		/**
		 * Look up a collection of {@link Event} in the {@link Log} given a collection
		 * of event ids. This is useful for looking up the event data for events found
		 * with the find_event_ids_* family of functions.
		 *
		 * Each {@link Event} which is not found in the {@link Log} is represented by
		 * NULL in the resulting collection. The query will be done via an asynchronous
		 * DBus call and this method will return immediately. The returned events will
		 * be passed to callback as a list of {@link Event}s, which must be the only
		 * argument of the function.
		 *
		 * In order to use this method there needs to be a mainloop runnning.
		 *
		 * @param event_ids a {@link GLib.Array} of {@link Event} ids
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async Zeitgeist.ResultSet get_events (GLib.Array<uint32> event_ids, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Gets extensions of the running Zeitgeist daemon.
		 *
		 * @return array of extenstions names strings
		 */
		public string[] get_extensions ();
		/**
		 * Gets version of currently running Zeitgeist daemon.
		 *
		 * This method will return the version of Zeitgeist daemon this instance is
		 * connected to. If you call this method right after zeitgeist_log_new(),
		 * only zeros will be returned, a valid version number will only be returned
		 * once this instance successfully connected to the Zeitgeist daemon - ie.
		 * the value of the "is-connected" property must be TRUE (you can connect
		 * to the "notify::is-connected" signal otherwise).
		 *
		 * @param major Location for the major version
		 * @param minor Location for the minor version
		 * @param micro Location for the micro version
		 */
		public void get_version (out int major, out int minor, out int micro);
		/**
		 * Asynchronously send a set of events to the Zeitgeist daemon, requesting they
		 * be inserted into the log.
		 *
		 * @param event A {@link Event}
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async GLib.Array<uint32> insert_event (Zeitgeist.Event event, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Asynchronously send a set of events to the Zeitgeist daemon, requesting they
		 * be inserted into the log.
		 * This method is &quot;fire and forget&quot; and the caller will never know
		 * whether the events was successfully inserted or not.
		 *
		 * This method is exactly equivalent to calling zeitgeist_log_insert_event()
		 * with NULL set as @cancellable, @callback, and @user_data.
		 *
		 * @param event A {@link Event}
		 */
		public void insert_event_no_reply (Zeitgeist.Event event) throws GLib.Error;
		/**
		 * Asynchronously send a set of events to the Zeitgeist daemon, requesting they
		 * be inserted into the log.
		 *
		 * @param events An {@link GLib.GenericArray} of {@link Event}
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async GLib.Array<uint32> insert_events (GLib.GenericArray<Zeitgeist.Event> events, GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Asynchronously send a set of events to the Zeitgeist daemon, requesting they
		 * be inserted into the log.
		 * This method is &quot;fire and forget&quot; and the caller will never know
		 * whether the events was successfully inserted or not.
		 *
		 * This method is exactly equivalent to calling zeitgeist_log_insert_event()
		 * with NULL set as @cancellable, @callback, and @user_data.
		 *
		 * @param events An {@link GLib.GenericArray} of {@link Event}
		 */
		public void insert_events_no_reply (GLib.GenericArray<Zeitgeist.Event> events) throws GLib.Error;
		/**
		 * Install a monitor in the Zeitgeist engine that calls back when events matching
		 * event_templates are logged. The matching is done exactly as in the find_* family
		 * of methods and in Event.matches_template. Furthermore matched events must also
		 * have timestamps lying in time_range.
		 *
		 * To remove a monitor call remove_monitor() on the returned Monitor instance.
		 *
		 * @param monitor A {@link Monitor} to report back inserts and deletes
		 */
		public void install_monitor (Zeitgeist.Monitor monitor) throws GLib.Error;
		protected override void on_connection_established ();
		protected override void on_connection_lost ();
		/**
		 * @param cancellable a {@link GLib.Cancellable} to cancel the operation or %NULL
		 */
		public async void quit (GLib.Cancellable? cancellable = null) throws GLib.Error;
		/**
		 * Remove a monitor from Zeitgeist engine that calls back when events matching event_templates are logged.
		 *
		 * @param monitor A {@link Monitor} to report back inserts and deletes
		 */
		public void remove_monitor (owned Zeitgeist.Monitor monitor) throws GLib.Error;
	}
	/**
	 * Listens for updates to the Zeitgeist event log
	 *
	 * A #Monitor listens for updates to the Zeitgeist event log
	 * matching a given set of templates and with timestamps in some predefined
	 * time range.
	 *
	 * A monitor must be installed into the running Zeitgeist daemon by calling
	 * zeitgeist_log_install_monitor(). The monitor will not emit any of the
	 * ::events-added or ::events-deleted signals before this.
	 */
	[CCode (cheader_filename = "zeitgeist.h")]
	public class Monitor : GLib.Object, Zeitgeist.RemoteMonitor {
		/**
		 * zeitgeist_monitor_new
		 *
		 * Create a new monitor. Before you can receive signals from the monitor you
		 * need to install it in the running Zeitgeist daemon by calling
		 * zeitgeist_log_install_monitor().
		 *
		 * @param time_range The monitor will only listen for events with
		 *     timestamps within this time range. Note that it is legal for
		 *     applications to insert events that are "in the past".
		 * @param event_templates A #GPtrArray of #ZeitgeistEvent<!-- -->s.
		 *     Only listen for events that match any of these templates.
		 *
		 * @return A reference to a newly allocated monitor
		 */
		public Monitor (Zeitgeist.TimeRange time_range, owned GLib.GenericArray<Zeitgeist.Event> event_templates);
		public GLib.ObjectPath get_path ();
		public GLib.GenericArray<Zeitgeist.Event> get_templates ();
		public GLib.GenericArray<Zeitgeist.Event> event_templates { get; set construct; }
		public Zeitgeist.TimeRange time_range { get; set construct; }
		/**
		 * ZeitgeistMonitor::events-deleted:
		 *
		 * Emitted when events with timestamps within the time range of this
		 * monitor have been deleted from the log. Note that the deleted events
		 * may not match the event templates for the monitor.
		 *
		 * @param time_range A #ZeitgeistTimeRange that specifies the minimum and
		 *     maximum timestamps of the deleted events
		 * @param event_ids A #GArray of #guint32<!-- -->s holding the IDs of the
		 *     deleted events
		 */
		public signal void events_deleted (Zeitgeist.TimeRange time_range, uint32[] event_ids);
		/**
		 * ZeitgeistMonitor::events-inserted:
		 *
		 * Emitted when events matching the event templates and with timestamps
		 * within the time range of the monitor has been inserted into the log.
		 *
		 * @param time_range A #ZeitgeistTimeRange that specifies the minimum and
		 *     maximum of the timestamps in @events
		 * @param events A #ZeitgeistResultSet holding the "ZeitgeistEvent"s that
		 *     have been inserted into the log
		 */
		public signal void events_inserted (Zeitgeist.TimeRange time_range, Zeitgeist.ResultSet events);
	}
	[CCode (cheader_filename = "zeitgeist.h")]
	protected abstract class QueuedProxyWrapper : GLib.Object {
		protected class QueuedMethod {
			public QueuedMethod (owned GLib.SourceFunc callback);
			public GLib.SourceFunc queued_method { get; private owned set; }
		}
		public QueuedProxyWrapper ();
		protected void name_owner_changed (GLib.ParamSpec pspec);
		protected abstract void on_connection_established ();
		protected abstract void on_connection_lost ();
		protected void process_queued_methods ();
		protected void proxy_acquired (GLib.Object proxy);
		protected void proxy_unavailable (GLib.IOError err);
		protected async void wait_for_proxy () throws GLib.Error;
		public bool is_connected { get; private set; }
		public bool proxy_created { get; private set; }
	}
	[CCode (cheader_filename = "zeitgeist.h")]
	[DBus (name = "net.connman.Manager")]
	protected interface ConnmanManagerDBus : GLib.Object {
		public abstract string get_state () throws GLib.IOError;
		public signal void state_changed (string state);
	}
	[CCode (cheader_filename = "zeitgeist.h")]
	[DBus (name = "org.freedesktop.NetworkManager")]
	protected interface NetworkManagerDBus : GLib.Object {
		[DBus (name = "state")]
		public abstract uint32 state () throws GLib.IOError;
		public signal void state_changed (uint32 state);
	}
	[CCode (cheader_filename = "zeitgeist.h")]
	[DBus (name = "org.gnome.zeitgeist.Log")]
	protected interface RemoteLog : GLib.Object {
		[DBus (signature = "(xx)")]
		public abstract async GLib.Variant delete_events (uint32[] event_ids, GLib.Cancellable? cancellable = null, GLib.BusName? sender = null) throws GLib.Error;
		public abstract async uint32[] find_event_ids ([DBus (signature = "(xx)")] GLib.Variant time_range, [DBus (signature = "a(asaasay)")] GLib.Variant event_templates, uint storage_state, uint num_events, uint result_type, GLib.Cancellable? cancellable = null, GLib.BusName? sender = null) throws GLib.Error;
		[DBus (signature = "a(asaasay)")]
		public abstract async GLib.Variant find_events ([DBus (signature = "(xx)")] GLib.Variant time_range, [DBus (signature = "a(asaasay)")] GLib.Variant event_templates, uint storage_state, uint num_events, uint result_type, GLib.Cancellable? cancellable = null, GLib.BusName? sender = null) throws GLib.Error;
		public abstract async string[] find_related_uris ([DBus (signature = "(xx)")] GLib.Variant time_range, [DBus (signature = "a(asaasay)")] GLib.Variant event_templates, [DBus (signature = "a(asaasay)")] GLib.Variant result_event_templates, uint storage_state, uint num_events, uint result_type, GLib.Cancellable? cancellable = null, GLib.BusName? sender = null) throws GLib.Error;
		[DBus (signature = "a(asaasay)")]
		public abstract async GLib.Variant get_events (uint32[] event_ids, GLib.Cancellable? cancellable = null, GLib.BusName? sender = null) throws GLib.Error;
		public abstract async uint32[] insert_events ([DBus (signature = "a(asaasay)")] GLib.Variant events, GLib.Cancellable? cancellable = null, GLib.BusName? sender = null) throws GLib.Error;
		public abstract async void install_monitor (GLib.ObjectPath monitor_path, [DBus (signature = "(xx)")] GLib.Variant time_range, [DBus (signature = "a(asaasay)")] GLib.Variant event_templates, GLib.BusName? owner = null) throws GLib.Error;
		public abstract async void quit (GLib.Cancellable? cancellable = null) throws GLib.Error;
		public abstract async void remove_monitor (GLib.ObjectPath monitor_path, GLib.BusName? owner = null) throws GLib.Error;
		[DBus (name = "datapath")]
		public abstract string datapath { owned get; }
		[DBus (name = "extensions")]
		public abstract string[] extensions { owned get; }
		[DBus (name = "version")]
		public abstract Zeitgeist.VersionStruct version { get; }
	}
	[CCode (cheader_filename = "zeitgeist.h")]
	[DBus (name = "org.gnome.zeitgeist.Monitor")]
	protected interface RemoteMonitor : GLib.Object {
		public abstract async void notify_delete ([DBus (signature = "(xx)")] GLib.Variant time_range, uint32[] event_ids) throws GLib.IOError;
		public abstract async void notify_insert ([DBus (signature = "(xx)")] GLib.Variant time_range, [DBus (signature = "a(asaasay)")] GLib.Variant events) throws GLib.Error;
	}
	[CCode (cheader_filename = "zeitgeist.h")]
	[DBus (name = "org.gnome.zeitgeist.DataSourceRegistry")]
	protected interface RemoteRegistry : GLib.Object {
		[DBus (signature = "(sssa(asaasay)bxb)")]
		public abstract async GLib.Variant get_data_source_from_id (string unique_id, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[DBus (signature = "a(sssa(asaasay)bxb)")]
		public abstract async GLib.Variant get_data_sources (GLib.Cancellable? cancellable = null) throws GLib.Error;
		public abstract async bool register_data_source (string unique_id, string name, string description, [DBus (signature = "a(asaasay)")] GLib.Variant event_templates, GLib.Cancellable? cancellable = null, GLib.BusName? sender = null) throws GLib.Error;
		public abstract async void set_data_source_enabled (string unique_id, bool enabled, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public signal void data_source_disconnected ([DBus (signature = "(sssa(asaasay)bxb)")] GLib.Variant data_source);
		public signal void data_source_enabled (string unique_id, bool enabled);
		public signal void data_source_registered ([DBus (signature = "(sssa(asaasay)bxb)")] GLib.Variant data_source);
	}
	[CCode (cheader_filename = "zeitgeist.h")]
	[DBus (name = "org.gnome.zeitgeist.Index")]
	protected interface RemoteSimpleIndexer : GLib.Object {
		public abstract async void search (string query_string, [DBus (signature = "(xx)")] GLib.Variant time_range, [DBus (signature = "a(asaasay)")] GLib.Variant filter_templates, uint offset, uint count, uint result_type, [DBus (signature = "a(asaasay)")] out GLib.Variant events, out uint matches, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public abstract async void search_with_relevancies (string query_string, [DBus (signature = "(xx)")] GLib.Variant time_range, [DBus (signature = "a(asaasay)")] GLib.Variant filter_templates, uint storage_state, uint offset, uint count, uint result_type, [DBus (signature = "a(asaasay)")] out GLib.Variant events, out double[] relevancies, out uint matches, GLib.Cancellable? cancellable = null) throws GLib.Error;
	}
	/**
	 * Version struct consisting of the following fields:
	 * - major
	 * - minor
	 * - minus
	 */
	[CCode (cheader_filename = "zeitgeist.h")]
	public struct VersionStruct {
		/**
		 * Major version number.
		 */
		public int major;
		/**
		 * Minor version number.
		 */
		public int minor;
		/**
		 * Micro version number.
		 */
		public int micro;
	}
}
