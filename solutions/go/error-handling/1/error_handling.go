// For my Shree DR.MDD
package erratum

func Use(opener ResourceOpener, arg string) (retErr error) {
	var res Resource
	for {
		res, retErr = opener()
		if _, transient := retErr.(TransientError); transient {
			continue
		} else if retErr != nil {
			return
		}
		break
	}
	defer res.Close()
	defer func() {
		if rec := recover(); rec != nil {
			if fe, ok := rec.(FrobError); ok {
				res.Defrob(fe.defrobTag)
			}
			retErr = rec.(error)
		}
	}()
	res.Frob(arg)
	return nil
}
