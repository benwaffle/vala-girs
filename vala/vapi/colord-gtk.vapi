/* colord-gtk.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Cd", gir_namespace = "ColordGtk", gir_version = "1.0", lower_case_cprefix = "cd_")]
namespace Cd {
	[CCode (cheader_filename = "colord-gtk.h", type_id = "cd_sample_window_get_type ()")]
	public class SampleWindow : Gtk.Window, Atk.Implementor, Gtk.Buildable {
		[CCode (has_construct_function = false, type = "GtkWindow*")]
		public SampleWindow ();
		public void set_fraction (double fraction);
	}
	[CCode (cheader_filename = "colord-gtk.h", type_id = "cd_window_get_type ()")]
	public class Window : GLib.Object {
		[CCode (has_construct_function = false)]
		public Window ();
		public static GLib.Quark error_quark ();
		public async void get_profile (Gtk.Widget widget, GLib.Cancellable? cancellable);
		[NoAccessorMethod]
		public string Profile { owned get; }
		public signal void changed (Cd.Profile object);
	}
	[CCode (cheader_filename = "colord-gtk.h", cprefix = "CD_WINDOW_ERROR_", has_type_id = false)]
	public enum WindowError {
		FAILED,
		LAST
	}
	[CCode (cheader_filename = "colord-gtk.h", cname = "CD_GTK_MAJOR_VERSION")]
	public const int GTK_MAJOR_VERSION;
	[CCode (cheader_filename = "colord-gtk.h", cname = "CD_GTK_MICRO_VERSION")]
	public const int GTK_MICRO_VERSION;
	[CCode (cheader_filename = "colord-gtk.h", cname = "CD_GTK_MINOR_VERSION")]
	public const int GTK_MINOR_VERSION;
}
