/* libgcab-1.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "GCab", gir_namespace = "GCab", gir_version = "1.0", lower_case_cprefix = "gcab_")]
namespace GCab {
	[CCode (cheader_filename = "libgcab.h", type_id = "gcab_cabinet_get_type ()")]
	public class Cabinet : GLib.Object {
		[CCode (has_construct_function = false)]
		public Cabinet ();
		public bool add_folder (GCab.Folder folder) throws GLib.Error;
		public bool extract (GLib.File path, [CCode (delegate_target_pos = 3.5)] GCab.FileCallback? file_callback, [CCode (delegate_target_pos = 3.5)] GLib.FileProgressCallback? progress_callback, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public bool extract_simple (GLib.File path, [CCode (delegate_target_pos = 2.5)] GCab.FileCallback? file_callback, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public GLib.GenericArray<GCab.Folder> get_folders ();
		public unowned GLib.ByteArray get_signature (GLib.Cancellable? cancellable = null) throws GLib.Error;
		public bool load (GLib.InputStream stream, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public bool write (GLib.OutputStream stream, [CCode (delegate_target_pos = 3.5)] GCab.FileCallback? file_callback, [CCode (delegate_target_pos = 3.5)] GLib.FileProgressCallback? progress_callback, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public bool write_simple (GLib.OutputStream stream, [CCode (delegate_target_pos = 2.5)] GCab.FileCallback? file_callback, GLib.Cancellable? cancellable = null) throws GLib.Error;
		[NoAccessorMethod]
		public GLib.ByteArray reserved { owned get; set; }
		[NoAccessorMethod]
		public GLib.ByteArray signature { owned get; set; }
	}
	[CCode (cheader_filename = "libgcab.h", type_id = "gcab_file_get_type ()")]
	public class File : GLib.Object {
		[CCode (has_construct_function = false)]
		protected File ();
		public uint32 get_attributes ();
		public void get_date (GLib.TimeVal result);
		public unowned string get_extract_name ();
		public GLib.File get_file ();
		public unowned string get_name ();
		public uint32 get_size ();
		public void set_extract_name (string? name);
		[CCode (has_construct_function = false)]
		public File.with_file (string name, GLib.File file);
		public GLib.File file { owned get; construct; }
		public string name { get; construct; }
	}
	[CCode (cheader_filename = "libgcab.h", type_id = "gcab_folder_get_type ()")]
	public class Folder : GLib.Object {
		[CCode (has_construct_function = false)]
		public Folder (int comptype);
		public bool add_file (GCab.File cabfile, bool recurse, GLib.Cancellable? cancellable = null) throws GLib.Error;
		public GLib.SList<GCab.File> get_files ();
		public uint get_nfiles ();
		[NoAccessorMethod]
		public GCab.Compression compression { get; }
		[NoAccessorMethod]
		public int comptype { get; construct; }
		[NoAccessorMethod]
		public GLib.ByteArray reserved { owned get; set; }
	}
	[CCode (cheader_filename = "libgcab.h", cprefix = "GCAB_COMPRESSION_", type_id = "gcab_compression_get_type ()")]
	public enum Compression {
		NONE,
		MSZIP,
		QUANTUM,
		LZX,
		MASK
	}
	[CCode (cheader_filename = "libgcab.h", cprefix = "GCAB_FILE_ATTRIBUTE_", type_id = "gcab_file_attribute_get_type ()")]
	public enum FileAttribute {
		RDONLY,
		HIDDEN,
		SYSTEM,
		ARCH,
		EXEC,
		NAME_IS_UTF
	}
	[CCode (cheader_filename = "libgcab.h", cprefix = "GCAB_ERROR_")]
	public errordomain Error {
		FORMAT,
		FAILED;
		public static GLib.Quark quark ();
	}
	[CCode (cheader_filename = "libgcab.h", instance_pos = 1.9)]
	public delegate bool FileCallback (GCab.File file);
}
