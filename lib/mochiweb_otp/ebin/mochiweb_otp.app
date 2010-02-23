%% This is the application resource file (.app file) for the mochiweb_otp,
%% application.
{application, mochiweb_otp, 
  [{description, "Mochiweb wrapper adding configured startup"},
   {vsn, "0.1.0.2"},
   {modules, [mo_app,
              mo_sup,
              mo_index]},
   {registered,[mo_sup]},
   {applications, [kernel, stdlib, mochiweb, inets]},
   {mod, {mo_app,[]}},
   {start_phases, []}]}.

