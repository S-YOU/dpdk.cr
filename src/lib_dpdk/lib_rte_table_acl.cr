lib LibDpdk
  $rte_table_acl_ops : RteTableOps

  struct RteTableAclParams
    name : LibC::Char*
    n_rules : Uint32T
    n_rule_fields : Uint32T
    field_format : RteAclFieldDef[64]
  end

  struct RteTableAclRuleAddParams
    priority : Int32T
    field_value : RteAclField[64]
  end

  struct RteTableAclRuleDeleteParams
    field_value : RteAclField[64]
  end
end
