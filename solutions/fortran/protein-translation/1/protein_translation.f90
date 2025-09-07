! For my Shree DR.MDD
module protein_translation
   implicit none

   private

   public proteins

contains

   function proteins(rna_seq) result(codon_names)
      character(len=*), intent(in) :: rna_seq
      character(len=13), allocatable :: codon_names(:)

      integer :: idx
      character(len=13), allocatable :: temp_list(:)
      character(len=3) :: cod
      character(len=len(rna_seq)) :: trimmed_rna

      trimmed_rna = trim(rna_seq)
      allocate(temp_list(len(rna_seq)/3))

      do idx = 1, size(temp_list)
         cod = trimmed_rna(1:3)
         trimmed_rna = trimmed_rna(4:)
         select case (cod)
         case ("AUG")
            temp_list(idx) = "Methionine"
         case ("UUU", "UUC")
            temp_list(idx) = "Phenylalanine"
         case ("UUA", "UUG")
            temp_list(idx) = "Leucine"
         case ("UCU", "UCC", "UCA", "UCG")
            temp_list(idx) = "Serine"
         case ("UAU", "UAC")
            temp_list(idx) = "Tyrosine"
         case ("UGU", "UGC")
            temp_list(idx) = "Cysteine"
         case ("UGG")
            temp_list(idx) = "Tryptophan"
         case ("UAA", "UAG", "UGA")
            exit
         case default
            temp_list(idx) = "Unknown"
         end select
      end do

      if (idx > 1) then
         allocate(codon_names(idx - 1))
         codon_names = temp_list(1:(idx - 1))
      else
         codon_names = [character(len=13) ::]
      end if

   end function proteins

end module protein_translation
