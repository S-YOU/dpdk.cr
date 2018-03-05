lib LibDpdk
  alias RteCfgfile = Void
  fun rte_cfgfile_close(cfg : RteCfgfile*) : LibC::Int
  fun rte_cfgfile_get_entry(cfg : RteCfgfile*, sectionname : LibC::Char*, entryname : LibC::Char*) : LibC::Char*
  fun rte_cfgfile_has_entry(cfg : RteCfgfile*, sectionname : LibC::Char*, entryname : LibC::Char*) : LibC::Int
  fun rte_cfgfile_has_section(cfg : RteCfgfile*, sectionname : LibC::Char*) : LibC::Int
  fun rte_cfgfile_load(filename : LibC::Char*, flags : LibC::Int) : RteCfgfile*
  fun rte_cfgfile_load_with_params(filename : LibC::Char*, flags : LibC::Int, params : RteCfgfileParameters*) : RteCfgfile*
  fun rte_cfgfile_num_sections(cfg : RteCfgfile*, sec_name : LibC::Char*, length : LibC::Int) : LibC::Int
  fun rte_cfgfile_section_entries(cfg : RteCfgfile*, sectionname : LibC::Char*, entries : RteCfgfileEntry*, max_entries : LibC::Int) : LibC::Int
  fun rte_cfgfile_section_entries_by_index(cfg : RteCfgfile*, index : LibC::Int, sectionname : LibC::Char*, entries : RteCfgfileEntry*, max_entries : LibC::Int) : LibC::Int
  fun rte_cfgfile_section_num_entries(cfg : RteCfgfile*, sectionname : LibC::Char*) : LibC::Int
  fun rte_cfgfile_sections(cfg : RteCfgfile*, sections : LibC::Char**, max_sections : LibC::Int) : LibC::Int

  struct RteCfgfileEntry
    name : LibC::Char[64]
    value : LibC::Char[256]
  end

  struct RteCfgfileParameters
    comment_character : LibC::Char
  end
end
