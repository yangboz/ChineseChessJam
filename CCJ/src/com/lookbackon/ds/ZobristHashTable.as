package com.lookbackon.ds
{
	import de.polygonal.ds.HashTable;
	import de.polygonal.math.PM_PRNG;
	/**
	 * These old hashes defined my requirements:
	 * The keys are unaligned variable-length byte arrays.
	 * Sometimes keys are several such arrays.
	 * Sometimes a set of independent hash functions were required.
	 * Average key lengths ranged from 8 bytes to 200 bytes.
	 * Keys might be character strings, numbers, bit-arrays, or weirder things.
	 * Table sizes could be anything, including powers of 2.
	 * The hash must be faster than the old one.
	 * The hash must do a good job. 
	 * 
	 * A Survey of Hash Functions:
	 * Additive Hash,
	 * Rotating Hash,
	 * One-at-a-Time Hash,
	 * Bernstein's hash,
	 * FNV Hash,
	 * Goulburn Hash,
	 * MurmurHash,
	 * Cessu,
	 * Pearson's Hash,
	 * CRC Hashing,
	 * Generalized CRC Hashing,
	 * Universal Hashing,
	 * Zobrist Hashing,
	 * Paul Hsieh's hash...
	 * 
	 * @see http://www.burtleburtle.net/bob/hash/doobs.html
	 * @inheritDoc
	 * @author Knight.zhou
	 * 
	 */	
	public class ZobristHashTable extends HashTable
	{
		private static var pm_prng:PM_PRNG = new PM_PRNG();
		
		public function ZobristHashTable(size:int)
		{
			//TODO: implement function
			super(size, ZobristHashTable.hashZobrist());
		}
		/**
		 * A simple function for zobrist hashing.
		 */
		public static function hashZobrist():int
		{
			return pm_prng.nextInt();
		}
	}
}