module PGENFiles
using BitIntegers
using CSV, DataFrames
import Mmap: mmap
import Base: unsafe_load
import GeneticVariantBase: GeneticData, Variant, VariantIterator, iterator
import GeneticVariantBase: chrom, pos, rsid, alleles, alt_allele, ref_allele
import GeneticVariantBase: maf, hwepval, infoscore, alt_dosages!
import GeneticVariantBase: n_samples, n_variants
export Pgen, iterator, n_samples, n_variants, get_genotypes, get_genotypes!
export alt_allele_dosage, alt_allele_dosage!, ref_allele_dosage, ref_allele_dosage!
BitIntegers.@define_integers 24
const variant_type_lengths = Dict(
    0x00 => (4, 1), 0x01 => (4, 2), 0x02 => (4, 3), 0x03 => (4, 4),
    0x04 => (8, 1), 0x05 => (8, 2), 0x06 => (8, 3), 0x07 => (8, 4)
)
const bytes_to_UInt = Dict(0x01 => UInt8, 0x02 => UInt16, 0x03 => UInt24, 0x04 => UInt32, 0x08 => UInt64)
const mask_map = [0x01, 0x03, 0x00, 0x0f, 0x00, 0x00, 0x00, 0xff]

@inline ceil_int(x::Integer, y::Integer) = (x ÷ y) + (x % y != 0)
include("uleb128.jl")
include("internal_structs.jl")
include("structs.jl")
include("header.jl")
include("difflist.jl")
include("iterator.jl")
include("genotype.jl")
include("dosage.jl")
datadir(parts...) = joinpath(@__DIR__, "..", "data", parts...)
end
