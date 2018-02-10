lib LibDpdk
  enum RteDistributorMatchFunction
    RteDistMatchScalar = 0
    RteDistMatchVector = 1
    RteDistNumMatchFns = 2
  end

  struct RteDistributor
    tailq_entry : Void*
    name : LibC::Char[32]
    num_workers : LibC::UInt
    alg_type : LibC::UInt
    in_flight_tags : LibC::Int[16][64]
    backlog : RteDistributorBacklog[64]
    bufs : RteDistributorBuffer[64]
    returns : RteDistributorReturnedPkts
    dist_match_fn : RteDistributorMatchFunction
    d_v20 : RteDistributorV20*
  end

  struct RteDistributorBacklog
    start : LibC::UInt
    count : LibC::UInt
    pkts : LibC::Int[8]
    tags : LibC::Int*
  end

  struct RteDistributorBuffer
    bufptr64 : LibC::Int[8]
    pad1 : LibC::Int
    retptr64 : LibC::Int[8]
    pad2 : LibC::Int
    count : LibC::Int
  end

  struct RteDistributorReturnedPkts
    start : LibC::UInt
    count : LibC::UInt
    mbufs : Void*[128]
  end

  struct RteDistributorV20
    tailq_entry : Void*
    name : LibC::Char[32]
    num_workers : LibC::UInt
    in_flight_tags : LibC::Int[64]
    in_flight_bitmask : LibC::Int
    backlog : RteDistributorBacklog[64]
    bufs : RteDistributorBufferV20[64]
    returns : RteDistributorReturnedPkts
  end

  union RteDistributorBufferV20
    bufptr64 : LibC::Int
    pad : LibC::Char
  end
end
